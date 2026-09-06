import {
  beforeEach,
  describe,
  expect,
  it,
  jest,
} from "@jest/globals";

jest.mock("firebase-functions/v2/https", () => ({
  /** Lightweight HttpsError substitute for callable tests. */
  HttpsError: class HttpsError extends Error {
    readonly code: string;

    /**
     * @param {string} code Callable error code.
     * @param {string} message Callable error message.
     */
    constructor(code: string, message: string) {
      super(message);
      this.name = "HttpsError";
      this.code = code;
    }
  },

  onCall: jest.fn((handler) => handler),
}));

import {createVerifyInstitutionEmailCode} from
  "../../src/verification/verify-code.function";
import {VerificationSessionRepository} from
  "../../src/verification/verification.repository";
import {verifyCode} from
  "../../src/verification/verification.service";
import {
  VerifyCodeRequest,
  VerifyCodeResponse,
} from "../../src/verification/verification.types";

jest.mock("../../src/verification/verification.service", () => ({
  verifyCode: jest.fn(),
}));

type VerifyCodeTestCallable = (
  request: {data: Partial<VerifyCodeRequest> | null},
) => Promise<VerifyCodeResponse>;

describe("createVerifyInstitutionEmailCode", () => {
  const repository =
    {} as VerificationSessionRepository;

  const callable =
    createVerifyInstitutionEmailCode(repository) as unknown as
      VerifyCodeTestCallable;

  const mockVerifyCode =
    verifyCode as jest.MockedFunction<typeof verifyCode>;

  beforeEach(() => {
    mockVerifyCode.mockReset();
  });

  it("verifies a valid OTP", async () => {
    mockVerifyCode.mockResolvedValueOnce({
      verified: true,
    });

    const result = await callable({
      data: {
        verificationSessionId: "session-123",
        code: "123456",
      },
    });

    expect(result).toEqual({
      verified: true,
    });

    expect(mockVerifyCode).toHaveBeenCalledWith(
      {
        verificationSessionId: "session-123",
        code: "123456",
      },
      repository,
    );
  });

  it("returns false for an incorrect OTP", async () => {
    mockVerifyCode.mockResolvedValueOnce({
      verified: false,
    });

    const result = await callable({
      data: {
        verificationSessionId: "session-123",
        code: "654321",
      },
    });

    expect(result).toEqual({
      verified: false,
    });
  });

  it("rejects a missing verification session ID", async () => {
    await expect(
      callable({
        data: {
          code: "123456",
        },
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message:
        "Verification session ID and code are required.",
    });

    expect(mockVerifyCode).not.toHaveBeenCalled();
  });

  it("rejects a missing verification code", async () => {
    await expect(
      callable({
        data: {
          verificationSessionId: "session-123",
        },
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message:
        "Verification session ID and code are required.",
    });

    expect(mockVerifyCode).not.toHaveBeenCalled();
  });

  it("rejects null request data", async () => {
    await expect(
      callable({
        data: null,
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message:
        "Verification session ID and code are required.",
    });

    expect(mockVerifyCode).not.toHaveBeenCalled();
  });

  it("rejects blank verification values", async () => {
    await expect(
      callable({
        data: {
          verificationSessionId: " ",
          code: " ",
        },
      }),
    ).rejects.toMatchObject({
      code: "invalid-argument",
      message:
        "Verification session ID and code are required.",
    });

    expect(mockVerifyCode).not.toHaveBeenCalled();
  });

  it("returns not-found when the session does not exist",
    async () => {
      mockVerifyCode.mockRejectedValueOnce(
        new Error("Verification session not found."),
      );

      await expect(
        callable({
          data: {
            verificationSessionId: "missing-session",
            code: "123456",
          },
        }),
      ).rejects.toMatchObject({
        code: "not-found",
        message: "Verification session not found.",
      });
    });

  it("returns internal when verification fails unexpectedly",
    async () => {
      const consoleError = jest.spyOn(console, "error")
        .mockImplementation(() => undefined);
      mockVerifyCode.mockRejectedValueOnce(
        new Error("Unexpected database failure"),
      );

      await expect(
        callable({
          data: {
            verificationSessionId: "session-123",
            code: "123456",
          },
        }),
      ).rejects.toMatchObject({
        code: "internal",
        message: "Unable to verify email code.",
      });

      expect(consoleError).toHaveBeenCalled();
      consoleError.mockRestore();
    });
});
