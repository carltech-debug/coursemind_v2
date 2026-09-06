import {getFirestore} from "firebase-admin/firestore";
import {setGlobalOptions} from "firebase-functions";

import {
  createGmailVerificationEmailService,
} from "./verification/email.service";
import {
  createResendInstitutionEmailVerification,
} from "./verification/resend-verification.function";
import {
  createStartInstitutionEmailVerification,
} from "./verification/start-verification.function";
import {
  createFirestoreVerificationSessionRepository,
} from "./verification/verification.repository";
import {
  createVerifyInstitutionEmailCode,
} from "./verification/verify-code.function";

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
export const verifyInstitutionEmailCode =
  createVerifyInstitutionEmailCode(
    verificationSessionRepository,
  );
export const resendInstitutionEmailVerification =
  createResendInstitutionEmailVerification(
    verificationSessionRepository,
    emailService,
  );
