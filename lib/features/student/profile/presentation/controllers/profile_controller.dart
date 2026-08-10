/*
==============================================================================
FILE: profile_controller.dart
MODULE: Student
FEATURE: Profile
LAYER: Presentation
COMPONENT: ProfileController
==============================================================================

DESCRIPTION
-----------
Manages the state and profile operations required by the Student Profile
feature.

The controller communicates with use cases rather than directly with
Firestore or the repository implementation.
==============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/user_profile_datasource.dart';
import '../../data/repositories/user_profile_repository_impl.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../../domain/usecases/check_profile_exists.dart';
import '../../domain/usecases/create_user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_user_profile.dart';

final userProfileDataSourceProvider = Provider<UserProfileDataSource>(
  (ref) {
    return UserProfileDataSource();
  },
);

final userProfileRepositoryProvider = Provider<UserProfileRepository>(
  (ref) {
    return UserProfileRepositoryImpl(
      dataSource: ref.read(userProfileDataSourceProvider),
    );
  },
);

final createUserProfileProvider = Provider<CreateUserProfile>(
  (ref) {
    return CreateUserProfile(
      repository: ref.read(userProfileRepositoryProvider),
    );
  },
);

final getUserProfileProvider = Provider<GetUserProfile>(
  (ref) {
    return GetUserProfile(
      repository: ref.read(userProfileRepositoryProvider),
    );
  },
);

final updateUserProfileProvider = Provider<UpdateUserProfile>(
  (ref) {
    return UpdateUserProfile(
      repository: ref.read(userProfileRepositoryProvider),
    );
  },
);

final checkProfileExistsProvider = Provider<CheckProfileExists>(
  (ref) {
    return CheckProfileExists(
      repository: ref.read(userProfileRepositoryProvider),
    );
  },
);

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, UserProfile?>(
  ProfileController.new,
);

class ProfileController extends AsyncNotifier<UserProfile?> {
  late final CreateUserProfile _createUserProfile;
  late final GetUserProfile _getUserProfile;
  late final UpdateUserProfile _updateUserProfile;
  late final CheckProfileExists _checkProfileExists;

  @override
  Future<UserProfile?> build() async {
    _createUserProfile = ref.read(createUserProfileProvider);
    _getUserProfile = ref.read(getUserProfileProvider);
    _updateUserProfile = ref.read(updateUserProfileProvider);
    _checkProfileExists = ref.read(checkProfileExistsProvider);

    return null;
  }

  Future<void> createProfile(UserProfile profile) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        await _createUserProfile(profile);
        return profile;
      },
    );
  }

  Future<void> loadProfile(String uid) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () {
        return _getUserProfile(uid);
      },
    );
  }

  Future<void> updateProfile(UserProfile profile) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        await _updateUserProfile(profile);
        return profile;
      },
    );
  }

  Future<bool> profileExists(String uid) {
    return _checkProfileExists(uid);
  }

  void clearProfile() {
    state = const AsyncData(null);
  }
}