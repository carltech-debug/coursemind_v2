/*
==============================================================================
FILE: user_profile.dart
MODULE: Student
FEATURE: Profile
LAYER: Domain
COMPONENT: UserProfile Entity
==============================================================================

DESCRIPTION
-----------
Core domain representation of a CourseMind student's profile.

This entity is independent of Firebase, Firestore, Flutter, and Riverpod.

The profile setup flow currently collects:
- Full name
- University
- Programme of study
- Current academic level

Firebase Authentication supplies:
- UID
- Email

Institution and programme IDs are retained so the profile can later connect
to CourseMind's Institution and Programme data structures.

==============================================================================
*/

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.institutionId,
    required this.institutionName,
    required this.programmeId,
    required this.programmeName,
    required this.academicLevel,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Firebase Authentication user ID.
  final String uid;

  /// Email associated with the Firebase Authentication account.
  final String email;

  /// Student's full name as entered during profile setup.
  final String fullName;

  /// ID of the student's institution.
  final String institutionId;

  /// Display name of the student's institution.
  final String institutionName;

  /// ID of the student's programme.
  final String programmeId;

  /// Display name of the student's programme.
  final String programmeName;

  /// Current academic level, e.g. 100, 200, 300, or 400.
  final String academicLevel;

  /// Optional profile image URL.
  final String? profileImageUrl;

  /// Profile creation timestamp.
  final DateTime? createdAt;

  /// Last profile modification timestamp.
  final DateTime? updatedAt;

  UserProfile copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? institutionId,
    String? institutionName,
    String? programmeId,
    String? programmeName,
    String? academicLevel,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      institutionId: institutionId ?? this.institutionId,
      institutionName: institutionName ?? this.institutionName,
      programmeId: programmeId ?? this.programmeId,
      programmeName: programmeName ?? this.programmeName,
      academicLevel: academicLevel ?? this.academicLevel,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}