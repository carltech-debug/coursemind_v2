/*
==============================================================================
FILE: user_profile_repository_impl.dart
MODULE: Student
FEATURE: Profile
LAYER: Data
COMPONENT: UserProfileRepositoryImpl
==============================================================================

DESCRIPTION
-----------
Concrete implementation of UserProfileRepository.

This class connects the domain repository contract to the Firestore
UserProfileDataSource.

The domain layer remains unaware of Firebase/Firestore.
==============================================================================
*/

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../datasource/user_profile_datasource.dart';
import '../models/user_profile_model.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl({
    required this._dataSource,
  });

  final UserProfileDataSource _dataSource;

  @override
  Future<void> createProfile(UserProfile profile) async {
    final model = UserProfileModel.fromEntity(profile);

    await _dataSource.createProfile(model);
  }

  @override
  Future<UserProfile?> getProfile(String uid) async {
    return _dataSource.getProfile(uid);
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    final model = UserProfileModel.fromEntity(profile);

    await _dataSource.updateProfile(model);
  }

  @override
  Future<bool> profileExists(String uid) async {
    return _dataSource.profileExists(uid);
  }
}