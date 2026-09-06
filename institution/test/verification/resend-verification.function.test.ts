import {
  beforeEach,
  describe,
  expect,
  it,
  jest,
} from "@jest/globals";

/** Mocks Firebase callable wrappers for unit tests. */
jest.mock("firebase-functions/v2/https", () => ({
  HttpsError: class HttpsError extends Error {
    readonly code: string;

    /**
     * @param {string} code Firebase callable error code.
     * @param {string} message Firebase callable error message.
     */
    constructor(code: string, message: string) {
      super(message);
      this.code = code;
    }
  },
  onCall: jest.fn((handler) => handler),
}));

import {
  createResendInstitutionEmailVerification,
} from "../../src/verification/resend-verification.function";
import {VerificationEmailService} from
  "../../src/verification/email.types";
import {VerificationSessionRepository} from
  "../../src/verification/verification.repository";
import {resendVerification} from
  "../../src/verification/verification.service";
import {
  ResendVerificationRequest,
  ResendVerificationResponse,
} from "../../src/verification/verification.types";

jest.mock("../../src/verification/verification.service", () => ({
  resendVerification: jest.fn(),
}));

type ResendTestCallable = (
  request: {data: Partial<ResendVerificationRequest> | null},
) => Promise<ResendVerificationResponse>;

describe("createResendInstitutionEmailVerification", () => {
  const repository = {} as VerificationSessionRepository;
  const emailService = {} as VerificationEmailService;
  const callable = createResendInstitutionEmailVerification(
    repository,
    emailService,
  ) as unknown as ResendTestCallable;
  const mockResendVerification =
    resendVerification as jest.MockedFunction<typeof resendVerification>;

  beforeEach(() => {
    mockResendVerification.mockReset();
  });

  it("returns only the public resend response", async () => {
    mockResendVerification.mockResolvedValueOnce({
      response: {
        verificationSessionId: "session-123",
        expiresIn: 540,
        resendAvailableIn: 60,
      },
      otp: "123456",
    });

    await expect(
      callable({
        data: {
          verificationSessionId: "session-123",
          email: "admin@example.com",
        },
      }),
    ).resolves.toEqual({
      verificationSessionId: "session-123",
      expiresIn: 540,
      resendAvailableIn: 60,
    });

    expect(mockResendVerification).toHaveBeenCalledWith(
      {
        verificationSessionId: "session-123",
        email: "admin@example.com",
      },
      repository,
      emailService,
    );
  });

  it("rejects missing email input", async () => {
    await expect(
      callable({
        data: {
          verificationSessionId: "session-123",
        },
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
    });

    expect(mockResendVerification).not.toHaveBeenCalled();
  });

  it("maps an email mismatch to permission-denied", async () => {
    mockResendVerification.mockRejectedValueOnce(
      new Error("Verification email does not match the session."),
    );

    await expect(
      callable({
        data: {
          verificationSessionId: "session-123",
          email: "other@example.com",
        },
      }),
    ).rejects.toMatchObject({
      code: "permission-denied",
    });
  });

  it("maps an active cooldown to resource-exhausted", async () => {
    mockResendVerification.mockRejectedValueOnce(
      new Error("Verification resend is on cooldown."),
    );

    await expect(
      callable({
        data: {
          verificationSessionId: "session-123",
          email: "admin@example.com",
        },
      }),
    ).rejects.toMatchObject({
      code: "resource-exhausted",
    });
  });
});
