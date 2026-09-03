import {
  describe,
  expect,
  it,
  jest,
} from "@jest/globals";

import {
  startVerification,
  VERIFICATION_SESSION_DURATION_MS,
} from "../../src/verification/verification.service";
import {
  VerificationSessionRepository,
} from "../../src/verification/verification.repository";
import {
  VerificationEmailService,
} from "../../src/verification/email.types";

/**
 * Creates a mocked verification session repository.
 *
 * @return {object} Mock repository and its create function.
 */
function createRepositoryMock(): {
  repository: VerificationSessionRepository;
  createMock: ReturnType<typeof jest.fn>;
  } {
  const createMock = jest.fn(
    async (): Promise<void> => {},
  );

  return {
    repository: {
      create: createMock,
    },
    createMock,
  };
}

/**
 * Creates a mocked verification email service.
 *
 * @return {object} Mock email service and its send function.
 */
function createEmailServiceMock(): {
  emailService: VerificationEmailService;
  sendVerificationCodeMock: ReturnType<typeof jest.fn>;
  } {
  const sendVerificationCodeMock = jest.fn(
    async (): Promise<void> => {},
  );

  return {
    emailService: {
      sendVerificationCode: sendVerificationCodeMock,
    },
    sendVerificationCodeMock,
  };
}

describe("startVerification", () => {
  it("creates and persists a verification session", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    expect(createMock).toHaveBeenCalledTimes(1);

    const persistedSession =
      createMock.mock.calls[0][0];

    expect(persistedSession.sessionId).toBe(
      result.response.verificationSessionId,
    );
  });

  it("returns the verification session ID", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    const persistedSession =
      createMock.mock.calls[0][0];

    expect(
      result.response.verificationSessionId,
    ).toBe(persistedSession.sessionId);
  });

  it("returns the expiration duration in seconds", async () => {
    const {repository} = createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    expect(result.response.expiresIn).toBe(
      VERIFICATION_SESSION_DURATION_MS / 1000,
    );
  });

  it("generates a six-digit OTP", async () => {
    const {repository} = createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    expect(result.otp).toMatch(/^\d{6}$/);
  });

  it("creates a pending verification session", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    const persistedSession =
      createMock.mock.calls[0][0];

    expect(persistedSession.status).toBe("pending");
  });

  it("starts with zero verification attempts", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    const persistedSession =
      createMock.mock.calls[0][0];

    expect(persistedSession.attempts).toBe(0);
  });

  it("does not expose the OTP in the public response", async () => {
    const {repository} = createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    expect(result.response).not.toHaveProperty(
      "otp",
    );
  });

  it("accepts and normalizes a valid email", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    await startVerification(
      {
        email: " ADMIN@example.com ",
      },
      repository,
      emailService,
    );

    const persistedSession =
      createMock.mock.calls[0][0];

    expect(persistedSession.emailHash).toMatch(
      /^[a-f0-9]{64}$/,
    );
  });

  it("rejects an empty email", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    await expect(
      startVerification(
        {
          email: "",
        },
        repository,
        emailService,
      ),
    ).rejects.toThrow(
      "A valid email is required.",
    );

    expect(createMock).not.toHaveBeenCalled();
  });

  it("rejects an invalid email", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    await expect(
      startVerification(
        {
          email: "invalid-email",
        },
        repository,
        emailService,
      ),
    ).rejects.toThrow(
      "A valid email is required.",
    );

    expect(createMock).not.toHaveBeenCalled();
  });

  it("does not persist a plaintext OTP", async () => {
    const {repository, createMock} =
      createRepositoryMock();

    const {emailService} =
      createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    const persistedSession =
      createMock.mock.calls[0][0];

    expect(
      JSON.stringify(persistedSession),
    ).not.toContain(result.otp);
  });

  it("sends the generated OTP through the email service", async () => {
    const {repository} = createRepositoryMock();

    const {
      emailService,
      sendVerificationCodeMock,
    } = createEmailServiceMock();

    const result = await startVerification(
      {
        email: "admin@example.com",
      },
      repository,
      emailService,
    );

    expect(
      sendVerificationCodeMock,
    ).toHaveBeenCalledTimes(1);

    expect(
      sendVerificationCodeMock,
    ).toHaveBeenCalledWith({
      recipientEmail: "admin@example.com",
      otp: result.otp,
      expiresIn:
        VERIFICATION_SESSION_DURATION_MS / 1000,
    });
  });
});
