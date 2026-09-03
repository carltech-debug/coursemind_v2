import {HttpsError, onCall} from "firebase-functions/v2/https";

import {VerificationEmailService} from "./email.types";
import {startVerification} from "./verification.service";
import {VerificationSessionRepository} from "./verification.repository";
import {StartVerificationRequest} from "./verification.types";

/**
 * Creates the administrator email verification callable.
 *
 * @param {VerificationSessionRepository} repository
 * Session persistence implementation.
 * @param {VerificationEmailService} emailService
 * Email delivery implementation.
 * @return {CallableFunction} Firebase callable function.
 */
export function createStartInstitutionEmailVerification(
  repository: VerificationSessionRepository,
  emailService: VerificationEmailService,
) {
  return onCall(async (request) => {
    const data =
      request.data as Partial<StartVerificationRequest>;

    if (typeof data.email !== "string") {
      throw new HttpsError(
        "invalid-argument",
        "A valid email is required.",
      );
    }

    try {
      const result = await startVerification(
        {
          email: data.email,
        },
        repository,
        emailService,
      );

      console.log(
        "Verification session created:",
        result.response.verificationSessionId,
      );

      return result.response;
    } catch (error) {
      if (error instanceof HttpsError) {
        throw error;
      }

      if (
        error instanceof Error &&
        error.message === "A valid email is required."
      ) {
        throw new HttpsError(
          "invalid-argument",
          error.message,
        );
      }

      console.error(
        "Failed to start institution email verification.",
        error,
      );

      throw new HttpsError(
        "internal",
        "Unable to start email verification.",
      );
    }
  });
}
