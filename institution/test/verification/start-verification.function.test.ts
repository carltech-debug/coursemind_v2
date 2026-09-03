import {describe, expect, it, jest} from "@jest/globals";

/**
 * Mocks the Firebase callable runtime for unit testing.
 */
jest.mock("firebase-functions/v2/https", () => ({
  HttpsError: class HttpsError extends Error {
    readonly code: string;

    /**
   * Creates a mocked Firebase HTTPS error.
   *
   * @param {string} code Firebase error code.
   * @param {string} message Error message.
   */
    constructor(code: string, message: string) {
      super(message);
      this.code = code;
      this.name = "HttpsError";
    }
  },

  onCall: jest.fn((handler) => handler),
}));

import {
  createStartInstitutionEmailVerification,
} from "../../src/verification/start-verification.function";

describe("startInstitutionEmailVerification", () => {
  const mockRepository = {
    create: jest.fn(
      async (): Promise<void> => {},
    ),
  };

  const mockEmailService = {
    sendVerificationCode: jest.fn(
      async (): Promise<void> => {},
    ),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns the public verification response", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    const result = await callable({
      data: {
        email: "admin@example.com",
      },
    });

    expect(result).toHaveProperty(
      "verificationSessionId",
    );

    expect(result).toHaveProperty(
      "expiresIn",
    );

    expect(result).not.toHaveProperty("otp");
  });

  it("returns a six-hundred-second expiration", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    const result = await callable({
      data: {
        email: "admin@example.com",
      },
    });

    expect(result.expiresIn).toBe(600);
  });

  it("persists the verification session", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    await callable({
      data: {
        email: "admin@example.com",
      },
    });

    expect(
      mockRepository.create,
    ).toHaveBeenCalledTimes(1);

    expect(
      mockRepository.create,
    ).toHaveBeenCalledWith(
      expect.objectContaining({
        sessionId: expect.any(String),
        emailHash: expect.any(String),
        otpHash: expect.any(String),
        expiresAt: expect.any(Number),
        attempts: 0,
        status: "pending",
      }),
    );
  });

  it("rejects a missing email", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    await expect(
      callable({
        data: {},
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message: "A valid email is required.",
    });
  });

  it("rejects a non-string email", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    await expect(
      callable({
        data: {
          email: 123,
        },
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message: "A valid email is required.",
    });
  });

  it("rejects an invalid email", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    await expect(
      callable({
        data: {
          email: "invalid-email",
        },
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message: "A valid email is required.",
    });
  });

  it("sends the generated OTP through the email service", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    await callable({
      data: {
        email: "admin@example.com",
      },
    });

    expect(
      mockEmailService.sendVerificationCode,
    ).toHaveBeenCalledTimes(1);

    expect(
      mockEmailService.sendVerificationCode,
    ).toHaveBeenCalledWith(
      expect.objectContaining({
        recipientEmail: "admin@example.com",
        otp: expect.stringMatching(/^\d{6}$/),
        expiresIn: 600,
      }),
    );
  });

  it("does not return the OTP in the callable response", async () => {
    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    const result = await callable({
      data: {
        email: "admin@example.com",
      },
    });

    expect(result).not.toHaveProperty("otp");
  });

  it("returns an internal error when email delivery fails", async () => {
    mockEmailService.sendVerificationCode
      .mockRejectedValueOnce(
        new Error("Email delivery failed."),
      );

    const callable =
      createStartInstitutionEmailVerification(
        mockRepository,
        mockEmailService,
      );

    await expect(
      callable({
        data: {
          email: "admin@example.com",
        },
      }),
    ).rejects.toMatchObject({
      code: "internal",
      message: "Unable to start email verification.",
    });
  });
});
