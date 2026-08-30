import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/institution_registration_state.dart';

final institutionRegistrationProvider = NotifierProvider<
    InstitutionRegistrationNotifier,
    InstitutionRegistrationState>(
  InstitutionRegistrationNotifier.new,
);

class InstitutionRegistrationNotifier
    extends Notifier<InstitutionRegistrationState> {
  @override
  InstitutionRegistrationState build() {
    return const InstitutionRegistrationState();
  }

  void updateInstitutionName(String value) {
    state = state.copyWith(institutionName: value);
  }

  void updateInstitutionType(String value) {
    state = state.copyWith(institutionType: value);
  }

  void updateCountry(String value) {
    state = state.copyWith(country: value);
  }

  void updateWebsite(String value) {
    state = state.copyWith(website: value);
  }

  void updateOfficialEmail(String value) {
    state = state.copyWith(officialEmail: value);
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

  void clearRegistration() {
    state = const InstitutionRegistrationState();
  }
}