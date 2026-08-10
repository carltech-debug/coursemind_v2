/*
==============================================================================
FILE: user_profile_model.dart
MODULE: Student
FEATURE: Profile
LAYER: Data
COMPONENT: UserProfileModel
==============================================================================

DESCRIPTION
-----------
Firestore-compatible representation of the UserProfile domain entity.

Responsibilities:
- Convert Firestore data into UserProfileModel.
- Convert UserProfileModel into Firestore data.
- Convert the domain UserProfile into UserProfileModel.

The domain layer remains independent of Firebase/Firestore.
==============================================================================
*/

import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {

  /// Creates a UserProfileModel from the domain entity.
  factory UserProfileModel.fromEntity(
    UserProfile profile,
  ) {
    return UserProfileModel(
      uid: profile.uid,
      email: profile.email,
      fullName: profile.fullName,
      institutionId: profile.institutionId,
      institutionName: profile.institutionName,
      programmeId: profile.programmeId,
      programmeName: profile.programmeName,
      academicLevel: profile.academicLevel,
      profileImageUrl: profile.profileImageUrl,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
  const UserProfileModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.institutionId,
    required super.institutionName,
    required super.programmeId,
    required super.programmeName,
    required super.academicLevel,
    super.profileImageUrl,
    super.createdAt,
    super.updatedAt,
  });

  /// Creates a UserProfileModel from Firestore data.
  factory UserProfileModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserProfileModel(
      uid: map['uid'] as String? ?? '',
      email: map['email'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      institutionId: map['institutionId'] as String? ?? '',
      institutionName: map['institutionName'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      programmeName: map['programmeName'] as String? ?? '',
      academicLevel: map['academicLevel'] as String? ?? '',
      profileImageUrl: map['profileImageUrl'] as String?,
      createdAt: _dateTimeFromValue(map['createdAt']),
      updatedAt: _dateTimeFromValue(map['updatedAt']),
    );
  }

  /// Converts the profile into a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'institutionId': institutionId,
      'institutionName': institutionName,
      'programmeId': programmeId,
      'programmeName': programmeName,
      'academicLevel': academicLevel,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Converts supported Firestore timestamp values to DateTime.
  static DateTime? _dateTimeFromValue(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    try {
      return value.toDate() as DateTime;
    } catch (_) {
      return null;
    }
  }
}