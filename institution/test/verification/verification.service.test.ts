import {describe, expect, it, jest} from "@jest/globals";
import {createHash} from "node:crypto";

import {
  createVerificationSession,
  isVerificationSessionExpired,
  startVerification,
  VERIFICATION_SESSION_DURATION_MS,
} from "../../src/verification/verification.service";
import {VerificationSessionRepository} from
  "../../src/verification/verification.repository";
import {VerificationSession} from
  "../../src/verification/verification.types";

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
  const mockEmailService = {
    sendVerificationCode: jest.fn(
      async (): Promise<void> => {},
    ),
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
