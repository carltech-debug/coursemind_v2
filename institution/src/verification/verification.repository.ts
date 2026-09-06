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

  /**
   * Retrieves a verification session by its identifier.
   *
   * @param {string} sessionId Verification session identifier.
   * @return {Promise<VerificationSession | null>} Stored session or null.
   */
  get(
    sessionId: string,
  ): Promise<VerificationSession | null>;

  /**
   * Updates an existing verification session.
   *
   * @param {VerificationSession} session Updated session.
   * @return {Promise<void>} Resolves when the session has been updated.
   */
  update(session: VerificationSession): Promise<void>;
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
        resendCount: session.resendCount,
        lastSentAt: session.lastSentAt,
        status: session.status,
      });
    },
    async get(sessionId: string): Promise<VerificationSession | null> {
      const doc = await sessions.doc(sessionId).get();
      if (!doc.exists) {
        return null;
      }
      const data = doc.data()!;
      return {
        sessionId: doc.id,
        emailHash: data.emailHash,
        otpHash: data.otpHash,
        expiresAt: data.expiresAt,
        attempts: data.attempts,
        resendCount: data.resendCount,
        lastSentAt: data.lastSentAt,
        status: data.status,
      };
    },
    async update(session: VerificationSession): Promise<void> {
      await sessions.doc(session.sessionId).update({
        emailHash: session.emailHash,
        otpHash: session.otpHash,
        expiresAt: session.expiresAt,
        attempts: session.attempts,
        resendCount: session.resendCount,
        lastSentAt: session.lastSentAt,
        status: session.status,
      });
    },
  };
}
