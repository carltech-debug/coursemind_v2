import {getFirestore} from "firebase-admin/firestore";
import {setGlobalOptions} from "firebase-functions";

import {
  createGmailVerificationEmailService,
} from "./verification/email.service";
import {
  createStartInstitutionEmailVerification,
} from "./verification/start-verification.function";
import {
  createFirestoreVerificationSessionRepository,
} from "./verification/verification.repository";

setGlobalOptions({maxInstances: 10});

const firestore = getFirestore();

const verificationSessionRepository =
  createFirestoreVerificationSessionRepository(
    firestore,
  );

const emailService =
  createGmailVerificationEmailService();

export const startInstitutionEmailVerification =
  createStartInstitutionEmailVerification(
    verificationSessionRepository,
    emailService,
  );
