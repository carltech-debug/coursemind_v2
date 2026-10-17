
class InstitutionRegistrationState {
  const InstitutionRegistrationState({
    this.institutionName = '',
    this.institutionType,
    this.country = 'Ghana',
    this.website = '',
    this.officialEmail = '',
    this.administratorFullName = '',
    this.administratorPosition,
    this.administratorEmail = '',
    this.administratorCountryCode = '+233',
    this.administratorPhone = '',
    this.profilePhotoPath,
    this.verificationSessionId,
    this.emailVerified = false,
    this.password = '',
    this.academicSetupDraft = const AcademicSetupDraft(),
  });

  final String institutionName;
  final String? institutionType;
  final String country;
  final String website;
  final String officialEmail;

  final String administratorFullName;
  final String? administratorPosition;
  final String administratorEmail;
  final String administratorCountryCode;
  final String administratorPhone;
  final String? profilePhotoPath;

  final String? verificationSessionId;
  final bool emailVerified;

  /// Temporary password used only during
  /// administrator account creation.
  ///
  /// This value must never be persisted
  /// to Firestore.
  final String password;

  /// Temporary frontend draft for academic setup.
  ///
  /// TODO(Screen 3 integration):
  /// Connect this draft to the established persistence
  /// flow after Firebase account creation and institution
  /// identity are available.
  ///
  /// Do not persist this draft directly to Firestore.
  final AcademicSetupDraft academicSetupDraft;

  InstitutionRegistrationState copyWith({
    String? institutionName,
    String? institutionType,
    String? country,
    String? website,
    String? officialEmail,
    String? administratorFullName,
    String? administratorPosition,
    String? administratorEmail,
    String? administratorCountryCode,
    String? administratorPhone,
    String? profilePhotoPath,
    String? verificationSessionId,
    bool? emailVerified,
    String? password,
    AcademicSetupDraft? academicSetupDraft,
  }) {
    return InstitutionRegistrationState(
      institutionName:
          institutionName ?? this.institutionName,
      institutionType:
          institutionType ?? this.institutionType,
      country: country ?? this.country,
      website: website ?? this.website,
      officialEmail: officialEmail ?? this.officialEmail,
      administratorFullName:
          administratorFullName ?? this.administratorFullName,
      administratorPosition:
          administratorPosition ?? this.administratorPosition,
      administratorEmail:
          administratorEmail ?? this.administratorEmail,
      administratorCountryCode:
          administratorCountryCode ?? this.administratorCountryCode,
      administratorPhone:
          administratorPhone ?? this.administratorPhone,
      profilePhotoPath:
          profilePhotoPath ?? this.profilePhotoPath,
      verificationSessionId:
          verificationSessionId ?? this.verificationSessionId,
      emailVerified: emailVerified ?? this.emailVerified,
      password: password ?? this.password,
      academicSetupDraft:
          academicSetupDraft ?? this.academicSetupDraft,
    );
  }
}

/// Temporary frontend-only academic setup data.
///
/// These values support the registration UI before the
/// account creation and persistence flow is integrated.
class AcademicSetupDraft {
  const AcademicSetupDraft({
    this.faculties = const [],
    this.levelCalendars = const [],
    this.curriculumFileName,
    this.curriculumName = '',
    this.curriculumVersion = '',
    this.curriculumDescription = '',
  });

  final List<AcademicFacultyDraft> faculties;
  final List<AcademicLevelCalendarDraft> levelCalendars;

  /// Name of the selected file, not proof of upload.
  final String? curriculumFileName;

  final String curriculumName;
  final String curriculumVersion;
  final String curriculumDescription;

  AcademicSetupDraft copyWith({
    List<AcademicFacultyDraft>? faculties,
    List<AcademicLevelCalendarDraft>? levelCalendars,
    String? curriculumFileName,
    bool clearCurriculumFileName = false,
    String? curriculumName,
    String? curriculumVersion,
    String? curriculumDescription,
  }) {
    return AcademicSetupDraft(
      faculties: faculties ?? this.faculties,
      levelCalendars: levelCalendars ?? this.levelCalendars,
      curriculumFileName: clearCurriculumFileName
          ? null
          : curriculumFileName ?? this.curriculumFileName,
      curriculumName: curriculumName ?? this.curriculumName,
      curriculumVersion: curriculumVersion ?? this.curriculumVersion,
      curriculumDescription:
          curriculumDescription ?? this.curriculumDescription,
    );
  }
}

class AcademicFacultyDraft {
  const AcademicFacultyDraft({
    required this.name,
    this.departments = const [],
  });

  final String name;
  final List<AcademicDepartmentDraft> departments;
}

class AcademicDepartmentDraft {
  const AcademicDepartmentDraft({
    required this.name,
    this.code = '',
    this.programmes = const [],
  });

  final String name;
  final String code;
  final List<AcademicProgrammeDraft> programmes;
}

class AcademicProgrammeDraft {
  const AcademicProgrammeDraft({
    required this.name,
    this.levels = const [],
  });

  final String name;
  final List<String> levels;
}

class AcademicLevelCalendarDraft {
  const AcademicLevelCalendarDraft({
    required this.level,
    this.academicYear = '',
    this.semester = '',
    this.semesterStart = '',
    this.semesterEnd = '',
    this.examStart = '',
    this.examEnd = '',
  });

  final int level;
  final String academicYear;
  final String semester;
  final String semesterStart;
  final String semesterEnd;
  final String examStart;
  final String examEnd;

  AcademicLevelCalendarDraft copyWith({
    String? academicYear,
    String? semester,
    String? semesterStart,
    String? semesterEnd,
    String? examStart,
    String? examEnd,
  }) {
    return AcademicLevelCalendarDraft(
      level: level,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      semesterStart: semesterStart ?? this.semesterStart,
      semesterEnd: semesterEnd ?? this.semesterEnd,
      examStart: examStart ?? this.examStart,
      examEnd: examEnd ?? this.examEnd,
    );
  }
}
