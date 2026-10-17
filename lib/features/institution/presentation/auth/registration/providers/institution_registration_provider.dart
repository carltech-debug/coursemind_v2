
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/services/firebase/'
    'institution_verification_service.dart';
import '../state/institution_registration_state.dart';

final institutionRegistrationProvider = NotifierProvider<
    InstitutionRegistrationNotifier,
    InstitutionRegistrationState>(
  InstitutionRegistrationNotifier.new,
);

class InstitutionRegistrationNotifier
    extends Notifier<InstitutionRegistrationState> {
  late final InstitutionVerificationService
      _verificationService;

  @override
  InstitutionRegistrationState build() {
    _verificationService = InstitutionVerificationService();

    return const InstitutionRegistrationState();
  }

  // ------------------------------------------------------------
  // EMAIL VERIFICATION
  // Keep this flow unchanged until Screen 3 is integrated.
  // ------------------------------------------------------------

  Future<StartVerificationResult> startEmailVerification() async {
    final email = state.administratorEmail.trim();

    if (email.isEmpty) {
      throw ArgumentError(
        'Administrator email is required.',
      );
    }

    final result = await _verificationService.startEmailVerification(
      email: email,
    );

    state = state.copyWith(
      verificationSessionId: result.verificationSessionId,
      emailVerified: false,
    );

    return result;
  }

  Future<VerifyVerificationResult> verifyEmailCode({
    required String code,
  }) async {
    final sessionId = state.verificationSessionId;

    if (sessionId == null || sessionId.isEmpty) {
      throw StateError(
        'No verification session is available.',
      );
    }

    final result = await _verificationService.verifyEmailCode(
      verificationSessionId: sessionId,
      code: code,
    );

    if (result.verified) {
      state = state.copyWith(
        emailVerified: true,
      );
    }

    return result;
  }

  Future<ResendVerificationResult> resendEmailVerification() async {
    final sessionId = state.verificationSessionId;

    if (sessionId == null || sessionId.isEmpty) {
      throw StateError(
        'No verification session is available.',
      );
    }

    final email = state.administratorEmail.trim();

    if (email.isEmpty) {
      throw ArgumentError(
        'Administrator email is required.',
      );
    }

    return _verificationService.resendEmailVerification(
      verificationSessionId: sessionId,
      email: email,
    );
  }

  // ------------------------------------------------------------
  // INSTITUTION REGISTRATION
  // ------------------------------------------------------------

  void updateInstitutionName(String value) {
    state = state.copyWith(
      institutionName: value,
    );
  }

  void updateInstitutionType(String value) {
    state = state.copyWith(
      institutionType: value,
    );
  }

  void updateCountry(String value) {
    state = state.copyWith(
      country: value,
    );
  }

  void updateWebsite(String value) {
    state = state.copyWith(
      website: value,
    );
  }

  void updateOfficialEmail(String value) {
    state = state.copyWith(
      officialEmail: value,
    );
  }

  void updateAdministratorFullName(String value) {
    state = state.copyWith(
      administratorFullName: value,
    );
  }

  void updateAdministratorPosition(String value) {
    state = state.copyWith(
      administratorPosition: value,
    );
  }

  void updateAdministratorEmail(String value) {
    state = state.copyWith(
      administratorEmail: value,
    );
  }

  void updateAdministratorCountryCode(String value) {
    state = state.copyWith(
      administratorCountryCode: value,
    );
  }

  void updateAdministratorPhone(String value) {
    state = state.copyWith(
      administratorPhone: value,
    );
  }

  void updateProfilePhotoPath(String? value) {
    state = state.copyWith(
      profilePhotoPath: value,
    );
  }

  void setVerificationSessionId(String value) {
    state = state.copyWith(
      verificationSessionId: value,
    );
  }

  void updatePassword(String value) {
    state = state.copyWith(
      password: value,
    );
  }

  void setEmailVerified(bool value) {
    state = state.copyWith(
      emailVerified: value,
    );
  }

  // ------------------------------------------------------------
  // ACADEMIC SETUP DRAFT
  // Temporary frontend state only.
  // No Firestore persistence or real file upload is performed.
  // ------------------------------------------------------------

  void updateAcademicFaculties(
    List<AcademicFacultyDraft> faculties,
  ) {
    state = state.copyWith(
      academicSetupDraft: state.academicSetupDraft.copyWith(
        faculties: List<AcademicFacultyDraft>.unmodifiable(
          faculties,
        ),
      ),
    );
  }

  void updateLevelCalendars(
    List<AcademicLevelCalendarDraft> calendars,
  ) {
    state = state.copyWith(
      academicSetupDraft: state.academicSetupDraft.copyWith(
        levelCalendars:
            List<AcademicLevelCalendarDraft>.unmodifiable(
          calendars,
        ),
      ),
    );
  }

  void updateLevelCalendar(
    AcademicLevelCalendarDraft updatedCalendar,
  ) {
    final calendars = [
      ...state.academicSetupDraft.levelCalendars,
    ];

    final index = calendars.indexWhere(
      (calendar) => calendar.level == updatedCalendar.level,
    );

    if (index == -1) {
      calendars.add(updatedCalendar);
    } else {
      calendars[index] = updatedCalendar;
    }

    state = state.copyWith(
      academicSetupDraft: state.academicSetupDraft.copyWith(
        levelCalendars:
            List<AcademicLevelCalendarDraft>.unmodifiable(
          calendars,
        ),
      ),
    );
  }

  void updateCurriculumFileName(String? fileName) {
    final currentDraft = state.academicSetupDraft;

    state = state.copyWith(
      academicSetupDraft: currentDraft.copyWith(
        curriculumFileName: fileName,
        clearCurriculumFileName: fileName == null,
      ),
    );
  }

  void updateCurriculumName(String value) {
    state = state.copyWith(
      academicSetupDraft: state.academicSetupDraft.copyWith(
        curriculumName: value,
      ),
    );
  }

  void updateCurriculumVersion(String value) {
    state = state.copyWith(
      academicSetupDraft: state.academicSetupDraft.copyWith(
        curriculumVersion: value,
      ),
    );
  }

  void updateCurriculumDescription(String value) {
    state = state.copyWith(
      academicSetupDraft: state.academicSetupDraft.copyWith(
        curriculumDescription: value,
      ),
    );
  }

  void clearAcademicSetupDraft() {
    state = state.copyWith(
      academicSetupDraft: const AcademicSetupDraft(),
    );
  }

  // ------------------------------------------------------------
  // RESET
  // ------------------------------------------------------------

  void clearRegistration() {
    state = const InstitutionRegistrationState();
  }
}
