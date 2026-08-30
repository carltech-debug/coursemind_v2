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
    this.emailVerified = false,
    this.password = '',
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

  final bool emailVerified;

  /// Temporary password used only during
  /// administrator account creation.
  ///
  /// This value must never be persisted
  /// to Firestore.
  final String password;

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
    bool? emailVerified,
    String? password,
  }) {
    return InstitutionRegistrationState(
      institutionName:
          institutionName ?? this.institutionName,
      institutionType:
          institutionType ?? this.institutionType,
      country:
          country ?? this.country,
      website:
          website ?? this.website,
      officialEmail:
          officialEmail ?? this.officialEmail,
      administratorFullName:
          administratorFullName ??
              this.administratorFullName,
      administratorPosition:
          administratorPosition ??
              this.administratorPosition,
      administratorEmail:
          administratorEmail ??
              this.administratorEmail,
      administratorCountryCode:
          administratorCountryCode ??
              this.administratorCountryCode,
      administratorPhone:
          administratorPhone ??
              this.administratorPhone,
      profilePhotoPath:
          profilePhotoPath ??
              this.profilePhotoPath,
      emailVerified:
          emailVerified ?? this.emailVerified,
      password:
          password ?? this.password,
    );
  }
}