/*
==============================================================================
FILE: user_profile_repository.dart
MODULE: Student
FEATURE: Profile
LAYER: Domain
COMPONENT: UserProfileRepository
==============================================================================

DESCRIPTION
-----------
Defines the contract for CourseMind student profile operations.

The domain layer does not know whether the profile is stored in Firestore,
another database, or another data source.

The concrete implementation will be created in the data layer later.
==============================================================================
*/

import '../entities/user_profile.dart';

abstract class UserProfileRepository {
  /// Creates or saves a student's profile.
  Future<void> createProfile(UserProfile profile);

  /// Retrieves a student's profile using their Firebase UID.
  Future<UserProfile?> getProfile(String uid);

  /// Updates an existing student's profile.
  Future<void> updateProfile(UserProfile profile);

  /// Determines whether a profile exists for the given Firebase UID.
  Future<bool> profileExists(String uid);
}