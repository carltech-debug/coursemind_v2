import {HttpsError, onCall} from "firebase-functions/v2/https";

import {VerificationSessionRepository} from "./verification.repository";
import {verifyCode} from "./verification.service";
import {VerifyCodeRequest} from "./verification.types";

/**
 * Creates the administrator email verification callable.
 *
 * @param {VerificationSessionRepository} repository
 * Verification session persistence implementation.
 * @return {CallableFunction} Firebase callable function.
 */
export function createVerifyInstitutionEmailCode(
  repository: VerificationSessionRepository,
) {
  return onCall(async (request) => {
    const data = request.data as Partial<VerifyCodeRequest> | null;

    if (
      data === null ||
      typeof data !== "object" ||
      typeof data.verificationSessionId !== "string" ||
      !data.verificationSessionId.trim() ||
      typeof data.code !== "string" ||
      !data.code.trim()
    ) {
      throw new HttpsError(
        "invalid-argument",
        "Verification session ID and code are required.",
      );
    }

    try {
      return await verifyCode(
        {
          verificationSessionId:
            data.verificationSessionId,
          code: data.code,
        },
        repository,
      );
    } catch (error) {
      if (error instanceof Error &&
          error.message ===
            "Verification session not found.") {
        throw new HttpsError(
          "not-found",
          error.message,
        );
      }

      console.error(
        "Failed to verify institution email code.",
        error,
      );

      throw new HttpsError(
        "internal",
        "Unable to verify email code.",
      );
    }
  });
}
