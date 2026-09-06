import {HttpsError, onCall} from "firebase-functions/v2/https";

import {VerificationEmailService} from "./email.types";
import {VerificationSessionRepository} from "./verification.repository";
import {resendVerification} from "./verification.service";
import {ResendVerificationRequest} from "./verification.types";

/**
 * Creates the institution email-verification resend callable.
 *
 * @param {VerificationSessionRepository} repository
 * Verification session persistence implementation.
 * @param {VerificationEmailService} emailService Email delivery implementation.
 * @return {CallableFunction} Firebase callable function.
 */
export function createResendInstitutionEmailVerification(
  repository: VerificationSessionRepository,
  emailService: VerificationEmailService,
) {
  return onCall(async (request) => {
    const data =
      request.data as Partial<ResendVerificationRequest> | null;

    if (
      data === null ||
      typeof data !== "object" ||
      typeof data.verificationSessionId !== "string" ||
      !data.verificationSessionId.trim() ||
      typeof data.email !== "string" ||
      !data.email.trim()
    ) {
      throw new HttpsError(
        "invalid-argument",
        "Verification session ID and email are required.",
      );
    }

    try {
      const result = await resendVerification(
        {
          verificationSessionId: data.verificationSessionId,
          email: data.email,
        },
        repository,
        emailService,
      );

      return result.response;
    } catch (error) {
      if (!(error instanceof Error)) {
        throw new HttpsError(
          "internal",
          "Unable to resend email verification.",
        );
      }

      if (error.message === "Verification session not found.") {
        throw new HttpsError("not-found", error.message);
      }

      if (error.message ===
          "Verification email does not match the session.") {
        throw new HttpsError("permission-denied", error.message);
      }

      if (error.message === "Verification resend is on cooldown.") {
        throw new HttpsError("resource-exhausted", error.message);
      }

      if (error.message === "Verification session is not pending." ||
          error.message === "Verification session has expired.") {
        throw new HttpsError("failed-precondition", error.message);
      }

      console.error(
        "Failed to resend institution email verification.",
        error,
      );
      throw new HttpsError(
        "internal",
        "Unable to resend email verification.",
      );
    }
  });
}
