import {
  beforeEach,
  describe,
  expect,
  it,
  jest,
} from "@jest/globals";
import {createHash} from "node:crypto";

import {
  createVerificationSession,
  isVerificationSessionExpired,
  MAX_VERIFICATION_ATTEMPTS,
  resendVerification,
  RESEND_COOLDOWN_MS,
  startVerification,
  verifyCode,
  VERIFICATION_SESSION_DURATION_MS,
} from "../../src/verification/verification.service";
import {VerificationSessionRepository} from
  "../../src/verification/verification.repository";
import {VerificationSession} from
  "../../src/verification/verification.types";
import {VerificationEmailService} from
  "../../src/verification/email.types";

/** In-memory persistence double for verification-service unit tests. */
class InMemoryVerificationSessionRepository implements
    VerificationSessionRepository {
  readonly sessions: VerificationSession[] = [];

  /**
   * Adds a session to the test store.
   *
   * @param {VerificationSession} session Session to store.
   * @return {Promise<void>} Resolves after storing the session.
   */
  async create(session: VerificationSession): Promise<void> {
    this.sessions.push(session);
  }

  /**
   * Retrieves a session from the test store.
   *
   * @param {string} sessionId Session identifier.
   * @return {Promise<VerificationSession | null>} Stored session or null.
   */
  async get(
    sessionId: string,
  ): Promise<VerificationSession | null> {
    return this.sessions.find(
      (session) => session.sessionId === sessionId,
    ) ?? null;
  }

  /**
   * Updates a session in the test store.
   *
   * @param {VerificationSession} session Updated session.
   * @return {Promise<void>} Resolves after updating the session.
   */
  async update(session: VerificationSession): Promise<void> {
    const index = this.sessions.findIndex(
      (storedSession) =>
        storedSession.sessionId === session.sessionId,
    );

    if (index !== -1) {
      this.sessions[index] = session;
    }
  }
}

describe("createVerificationSession", () => {
  it("creates a pending verification session", () => {
    const result = createVerificationSession(
      "admin@example.com",
    );

    expect(result.session.status).toBe("pending");
  });

  it("starts with zero verification attempts", () => {
    const result = createVerificationSession(
      "admin@example.com",
    );

    expect(result.session.attempts).toBe(0);
  });

  it("creates a unique session ID", () => {
    const first = createVerificationSession(
      "admin@example.com",
    );

    const second = createVerificationSession(
      "admin@example.com",
    );

    expect(first.session.sessionId).not.toBe(
      second.session.sessionId,
    );
  });

  it("generates a six-digit OTP", () => {
    const result = createVerificationSession(
      "admin@example.com",
    );

    expect(result.otp).toMatch(/^\d{6}$/);
  });

  it("associates the session with a hash of its OTP", () => {
    const result = createVerificationSession(
      "admin@example.com",
    );

    const expectedHash = createHash("sha256")
      .update(result.otp)
      .digest("hex");

    expect(result.session.otpHash).toBe(expectedHash);
    expect(result.session.otpHash).not.toBe(result.otp);
  });

  it("hashes the email instead of storing it directly", () => {
    const result = createVerificationSession(
      "ADMIN@example.com",
    );

    expect(result.session.emailHash).not.toBe(
      "ADMIN@example.com",
    );

    expect(result.session.emailHash).toMatch(
      /^[a-f0-9]{64}$/,
    );
  });

  it("sets an expiration time from the session creation time", () => {
    const createdAt = 1_700_000_000_000;
    const result = createVerificationSession(
      "admin@example.com",
      createdAt,
    );

    expect(result.session.expiresAt).toBe(
      createdAt + VERIFICATION_SESSION_DURATION_MS,
    );
  });

  it("identifies an expired session", () => {
    const createdAt = 1_700_000_000_000;
    const result = createVerificationSession(
      "admin@example.com",
      createdAt,
    );

    expect(
      isVerificationSessionExpired(
        result.session,
        result.session.expiresAt - 1,
      ),
    ).toBe(false);

    expect(
      isVerificationSessionExpired(
        result.session,
        result.session.expiresAt,
      ),
    ).toBe(true);
  });

  it("normalizes the email before hashing", () => {
    const first = createVerificationSession(
      "ADMIN@example.com",
    );

    const second = createVerificationSession(
      " admin@example.com ",
    );

    expect(first.session.emailHash).toBe(
      second.session.emailHash,
    );
  });

  it("rejects an empty email", () => {
    expect(() =>
      createVerificationSession(""),
    ).toThrow("Email is required.");
  });

  it("rejects whitespace-only email", () => {
    expect(() =>
      createVerificationSession("   "),
    ).toThrow("Email is required.");
  });

  it("does not store the plaintext OTP in the session", () => {
    const result = createVerificationSession(
      "admin@example.com",
    );

    expect(
      JSON.stringify(result.session),
    ).not.toContain(result.otp);
  });
});

describe("startVerification", () => {
  const mockEmailService: VerificationEmailService = {
    sendVerificationCode:
    jest.fn<VerificationEmailService["sendVerificationCode"]>(),
  };

  it("persists a pending session and returns public data", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    const result = await startVerification(
      {email: "admin@example.com"},
      repository,
      mockEmailService,
    );

    expect(repository.sessions).toHaveLength(1);

    expect(
      result.response.verificationSessionId,
    ).toBe(repository.sessions[0].sessionId);

    expect(result.response.expiresIn).toBe(600);

    expect(Object.keys(result.response)).toEqual([
      "verificationSessionId",
      "expiresIn",
    ]);
  });

  it("rejects an invalid email without storing a session", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    await expect(
      startVerification(
        {email: "not-an-email"},
        repository,
        mockEmailService,
      ),
    ).rejects.toThrow(
      "A valid email is required.",
    );

    expect(repository.sessions).toHaveLength(0);
  });
});

describe("verifyCode", () => {
  it("verifies a correct OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    const created = createVerificationSession(
      "admin@example.com",
    );

    await repository.create(created.session);

    const result = await verifyCode(
      {
        verificationSessionId:
          created.session.sessionId,
        code: created.otp,
      },
      repository,
    );

    expect(result.verified).toBe(true);
  });

  it("marks the session as verified after a correct OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    const created = createVerificationSession(
      "admin@example.com",
    );

    await repository.create(created.session);

    await verifyCode(
      {
        verificationSessionId:
          created.session.sessionId,
        code: created.otp,
      },
      repository,
    );

    const storedSession = await repository.get(
      created.session.sessionId,
    );

    expect(storedSession?.status).toBe("verified");
  });

  it("rejects an incorrect OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    const created = createVerificationSession(
      "admin@example.com",
    );

    await repository.create(created.session);

    const result = await verifyCode(
      {
        verificationSessionId:
          created.session.sessionId,
        code: "000000",
      },
      repository,
    );

    expect(result.verified).toBe(false);
  });

  it("increments attempts after an incorrect OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const created = createVerificationSession(
      "admin@example.com",
    );

    await repository.create(created.session);

    await verifyCode(
      {
        verificationSessionId: created.session.sessionId,
        code: "000000",
      },
      repository,
    );

    const storedSession = await repository.get(
      created.session.sessionId,
    );

    expect(storedSession?.attempts).toBe(1);
  });

  it("does not verify the session when the OTP is incorrect",
    async () => {
      const repository =
        new InMemoryVerificationSessionRepository();

      const created = createVerificationSession(
        "admin@example.com",
      );

      await repository.create(created.session);

      await verifyCode(
        {
          verificationSessionId:
            created.session.sessionId,
          code: "000000",
        },
        repository,
      );

      const storedSession = await repository.get(
        created.session.sessionId,
      );

      expect(storedSession?.status).toBe("pending");
    });

  it("keeps the session pending before the attempt limit",
    async () => {
      const repository =
        new InMemoryVerificationSessionRepository();
      const created = createVerificationSession(
        "admin@example.com",
      );
      const session: VerificationSession = {
        ...created.session,
        attempts: MAX_VERIFICATION_ATTEMPTS - 2,
      };

      await repository.create(session);

      await verifyCode(
        {
          verificationSessionId: session.sessionId,
          code: "000000",
        },
        repository,
      );

      const storedSession = await repository.get(
        session.sessionId,
      );

      expect(storedSession).toMatchObject({
        attempts: MAX_VERIFICATION_ATTEMPTS - 1,
        status: "pending",
      });
    });

  it("locks the session after the final failed attempt", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const created = createVerificationSession(
      "admin@example.com",
    );
    const session: VerificationSession = {
      ...created.session,
      attempts: MAX_VERIFICATION_ATTEMPTS - 1,
    };

    await repository.create(session);

    const result = await verifyCode(
      {
        verificationSessionId: session.sessionId,
        code: "000000",
      },
      repository,
    );

    expect(result.verified).toBe(false);

    const storedSession = await repository.get(
      session.sessionId,
    );

    expect(storedSession).toMatchObject({
      attempts: MAX_VERIFICATION_ATTEMPTS,
      status: "locked",
    });
  });

  it("does not verify a locked session", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const created = createVerificationSession(
      "admin@example.com",
    );
    const lockedSession: VerificationSession = {
      ...created.session,
      attempts: MAX_VERIFICATION_ATTEMPTS,
      status: "locked",
    };

    await repository.create(lockedSession);

    const result = await verifyCode(
      {
        verificationSessionId: lockedSession.sessionId,
        code: created.otp,
      },
      repository,
    );

    expect(result.verified).toBe(false);

    const storedSession = await repository.get(
      lockedSession.sessionId,
    );

    expect(storedSession).toEqual(lockedSession);
  });

  it("trims whitespace around a valid OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    const created = createVerificationSession(
      "admin@example.com",
    );

    await repository.create(created.session);

    const result = await verifyCode(
      {
        verificationSessionId:
          created.session.sessionId,
        code: `  ${created.otp}  `,
      },
      repository,
    );

    expect(result.verified).toBe(true);
  });

  it("does not increment attempts after a correct OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const created = createVerificationSession(
      "admin@example.com",
    );
    const session: VerificationSession = {
      ...created.session,
      attempts: 2,
    };

    await repository.create(session);

    const result = await verifyCode(
      {
        verificationSessionId: session.sessionId,
        code: created.otp,
      },
      repository,
    );

    expect(result.verified).toBe(true);

    const storedSession = await repository.get(
      session.sessionId,
    );

    expect(storedSession).toMatchObject({
      attempts: 2,
      status: "verified",
    });
  });

  it("throws when the verification session does not exist",
    async () => {
      const repository =
        new InMemoryVerificationSessionRepository();

      await expect(
        verifyCode(
          {
            verificationSessionId: "missing-session",
            code: "123456",
          },
          repository,
        ),
      ).rejects.toThrow(
        "Verification session not found.",
      );
    });

  it("returns true without changing an already verified session",
    async () => {
      const repository =
        new InMemoryVerificationSessionRepository();

      const created = createVerificationSession(
        "admin@example.com",
      );

      const verifiedSession: VerificationSession = {
        ...created.session,
        status: "verified",
      };

      await repository.create(verifiedSession);

      const result = await verifyCode(
        {
          verificationSessionId:
            created.session.sessionId,
          code: "000000",
        },
        repository,
      );

      expect(result.verified).toBe(true);
    });
  it("expires an expired verification session", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();

    const createdAt = 1_700_000_000_000;

    const created = createVerificationSession(
      "admin@example.com",
      createdAt,
    );

    await repository.create(created.session);

    const result = await verifyCode(
      {
        verificationSessionId:
          created.session.sessionId,
        code: created.otp,
      },
      repository,
      created.session.expiresAt,
    );

    expect(result.verified).toBe(false);

    const storedSession = await repository.get(
      created.session.sessionId,
    );

    expect(storedSession?.status).toBe("expired");
  });
});

describe("resendVerification", () => {
  const resendSendVerificationCode =
  jest.fn<VerificationEmailService["sendVerificationCode"]>();

  const emailService = {
    sendVerificationCode:
    resendSendVerificationCode,
  };

  beforeEach(() => {
    emailService.sendVerificationCode.mockReset();
  });

  it("replaces the OTP and resets failed attempts", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const createdAt = 1_700_000_000_000;
    const created = createVerificationSession(
      "Admin@example.com",
      createdAt,
    );
    const session: VerificationSession = {
      ...created.session,
      attempts: 2,
    };

    await repository.create(session);

    const result = await resendVerification(
      {
        verificationSessionId: session.sessionId,
        email: " admin@example.com ",
      },
      repository,
      emailService,
      createdAt + RESEND_COOLDOWN_MS,
    );

    expect(result.response).toEqual({
      verificationSessionId: session.sessionId,
      expiresIn: 540,
      resendAvailableIn: 60,
    });

    const storedSession = await repository.get(
      session.sessionId,
    );

    expect(storedSession).toMatchObject({
      attempts: 0,
      resendCount: 1,
      lastSentAt: createdAt + RESEND_COOLDOWN_MS,
      status: "pending",
    });
    expect(storedSession?.otpHash).not.toBe(session.otpHash);
    expect(emailService.sendVerificationCode).toHaveBeenCalledWith({
      recipientEmail: "admin@example.com",
      otp: result.otp,
      expiresIn: 540,
    });
  });

  it("rejects an email that does not match the session", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const createdAt = 1_700_000_000_000;
    const created = createVerificationSession(
      "admin@example.com",
      createdAt,
    );

    await repository.create(created.session);

    await expect(
      resendVerification(
        {
          verificationSessionId: created.session.sessionId,
          email: "other@example.com",
        },
        repository,
        emailService,
        createdAt + RESEND_COOLDOWN_MS,
      ),
    ).rejects.toThrow(
      "Verification email does not match the session.",
    );

    expect(emailService.sendVerificationCode).not.toHaveBeenCalled();
  });

  it("enforces the resend cooldown", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const createdAt = 1_700_000_000_000;
    const created = createVerificationSession(
      "admin@example.com",
      createdAt,
    );

    await repository.create(created.session);

    await expect(
      resendVerification(
        {
          verificationSessionId: created.session.sessionId,
          email: "admin@example.com",
        },
        repository,
        emailService,
        createdAt + RESEND_COOLDOWN_MS - 1,
      ),
    ).rejects.toThrow("Verification resend is on cooldown.");
  });

  it("expires a session instead of resending an OTP", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const createdAt = 1_700_000_000_000;
    const created = createVerificationSession(
      "admin@example.com",
      createdAt,
    );

    await repository.create(created.session);

    await expect(
      resendVerification(
        {
          verificationSessionId: created.session.sessionId,
          email: "admin@example.com",
        },
        repository,
        emailService,
        created.session.expiresAt,
      ),
    ).rejects.toThrow("Verification session has expired.");

    const storedSession = await repository.get(
      created.session.sessionId,
    );
    expect(storedSession?.status).toBe("expired");
  });

  it("does not resend a locked session", async () => {
    const repository =
      new InMemoryVerificationSessionRepository();
    const createdAt = 1_700_000_000_000;
    const created = createVerificationSession(
      "admin@example.com",
      createdAt,
    );
    const lockedSession: VerificationSession = {
      ...created.session,
      attempts: MAX_VERIFICATION_ATTEMPTS,
      status: "locked",
    };

    await repository.create(lockedSession);

    await expect(
      resendVerification(
        {
          verificationSessionId: lockedSession.sessionId,
          email: "admin@example.com",
        },
        repository,
        emailService,
        createdAt + RESEND_COOLDOWN_MS,
      ),
    ).rejects.toThrow("Verification session is not pending.");

    expect(emailService.sendVerificationCode).not.toHaveBeenCalled();
  });
});
