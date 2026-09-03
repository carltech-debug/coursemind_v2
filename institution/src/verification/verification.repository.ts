import {Firestore} from "firebase-admin/firestore";

import {VerificationSession} from "./verification.types";

export const VERIFICATION_SESSIONS_COLLECTION =
  "verificationSessions";

/** Persists verification sessions independently of the verification flow. */
export interface VerificationSessionRepository {
  /**
   * Stores a newly created verification session.
   *
   * @param {VerificationSession} session Session to store.
   * @return {Promise<void>} Resolves when the session has been stored.
   */
  create(session: VerificationSession): Promise<void>;
}

/**
 * Creates a repository backed by Cloud Firestore.
 *
 * OTPs are represented only by their hash in the session document.
 *
 * @param {Firestore} firestore Firestore instance for the Functions project.
 * @return {VerificationSessionRepository} Firestore-backed session repository.
 */
export function createFirestoreVerificationSessionRepository(
  firestore: Firestore,
): VerificationSessionRepository {
  const sessions = firestore.collection(
    VERIFICATION_SESSIONS_COLLECTION,
  );

  return {
    async create(session: VerificationSession): Promise<void> {
      await sessions.doc(session.sessionId).create({
        emailHash: session.emailHash,
        otpHash: session.otpHash,
        expiresAt: session.expiresAt,
        attempts: session.attempts,
        status: session.status,
      });
    },
  };
}
