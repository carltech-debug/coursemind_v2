import {describe, expect, it, jest} from "@jest/globals";

import {
  createFirestoreVerificationSessionRepository,
} from "../../src/verification/verification.repository";

describe("createFirestoreVerificationSessionRepository", () => {
  const createFirestoreMock = () => {
    const create = jest.fn(
      (data: Record<string, unknown>) => {
        void data;
        return Promise.resolve();
      },
    );

    const get = jest.fn(() =>
      Promise.resolve({
        exists: false,
        id: "",
        data: () => ({}),
      }),
    );

    const update = jest.fn(
      (data: Record<string, unknown>) => {
        void data;
        return Promise.resolve();
      },
    );

    const doc = jest.fn((sessionId: string) => {
      void sessionId;

      return {
        create,
        get,
        update,
      };
    });

    const collection = jest.fn(
      (collectionName: string) => {
        void collectionName;

        return {
          doc,
        };
      },
    );

    return {
      firestore: {
        collection,
      },
      collection,
      doc,
      create,
      get,
      update,
    };
  };

  const session = {
    sessionId: "session-123",
    emailHash: "email-hash",
    otpHash: "otp-hash",
    expiresAt: 1_800_000_000_000,
    attempts: 0,
    resendCount: 0,
    lastSentAt: 1_700_000_000_000,
    status: "pending" as const,
  };

  it("creates a verification session", async () => {
    const mock = createFirestoreMock();

    mock.create.mockResolvedValueOnce();

    const repository =
      createFirestoreVerificationSessionRepository(
        mock.firestore as never,
      );

    await repository.create(session);

    expect(mock.collection).toHaveBeenCalledWith(
      "verificationSessions",
    );

    expect(mock.doc).toHaveBeenCalledWith(
      "session-123",
    );

    expect(mock.create).toHaveBeenCalledWith({
      emailHash: session.emailHash,
      otpHash: session.otpHash,
      expiresAt: session.expiresAt,
      attempts: session.attempts,
      resendCount: session.resendCount,
      lastSentAt: session.lastSentAt,
      status: session.status,
    });
  });

  it("retrieves an existing verification session", async () => {
    const mock = createFirestoreMock();

    mock.get.mockResolvedValueOnce({
      exists: true,
      id: session.sessionId,
      data: () => ({
        emailHash: session.emailHash,
        otpHash: session.otpHash,
        expiresAt: session.expiresAt,
        attempts: session.attempts,
        resendCount: session.resendCount,
        lastSentAt: session.lastSentAt,
        status: session.status,
      }),
    });

    const repository =
      createFirestoreVerificationSessionRepository(
        mock.firestore as never,
      );

    await expect(
      repository.get(session.sessionId),
    ).resolves.toEqual(session);
  });

  it("returns null when a verification session does not exist", async () => {
    const mock = createFirestoreMock();

    mock.get.mockResolvedValueOnce({
      exists: false,
      id: session.sessionId,
      data: () => ({}),
    });

    const repository =
      createFirestoreVerificationSessionRepository(
        mock.firestore as never,
      );

    await expect(
      repository.get(session.sessionId),
    ).resolves.toBeNull();
  });

  it("updates a verification session", async () => {
    const mock = createFirestoreMock();

    const updatedSession = {
      ...session,
      attempts: 1,
      resendCount: 1,
      lastSentAt: 1_700_000_060_000,
      status: "pending" as const,
    };

    mock.update.mockResolvedValueOnce();

    const repository =
      createFirestoreVerificationSessionRepository(
        mock.firestore as never,
      );

    await repository.update(updatedSession);

    expect(mock.update).toHaveBeenCalledWith({
      emailHash: updatedSession.emailHash,
      otpHash: updatedSession.otpHash,
      expiresAt: updatedSession.expiresAt,
      attempts: updatedSession.attempts,
      resendCount: updatedSession.resendCount,
      lastSentAt: updatedSession.lastSentAt,
      status: updatedSession.status,
    });
  });

  it("never stores a plaintext OTP", async () => {
    const mock = createFirestoreMock();

    mock.create.mockResolvedValueOnce();

    const repository =
      createFirestoreVerificationSessionRepository(
        mock.firestore as never,
      );

    await repository.create(session);

    const storedData = mock.create.mock.calls[0][0];

    expect(storedData).not.toHaveProperty("otp");
    expect(storedData.otpHash).toBe("otp-hash");
  });
});
