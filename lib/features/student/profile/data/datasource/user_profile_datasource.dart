/*
==============================================================================
FILE: user_profile_datasource.dart
MODULE: Student
FEATURE: Profile
LAYER: Data
COMPONENT: UserProfileDataSource
==============================================================================

DESCRIPTION
-----------
Handles direct Firestore operations for CourseMind student profiles.

Firestore structure:

users/{uid}

The datasource is the only profile layer that communicates directly with
Cloud Firestore.

==============================================================================
*/

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile_model.dart';

class UserProfileDataSource {
  UserProfileDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  /// Creates or overwrites a student profile.
  Future<void> createProfile(UserProfileModel profile) async {
    await _usersCollection.doc(profile.uid).set(
          profile.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Retrieves a student profile by Firebase UID.
  Future<UserProfileModel?> getProfile(String uid) async {
    final document = await _usersCollection.doc(uid).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return UserProfileModel.fromMap(document.data()!);
  }

  /// Updates an existing student profile.
  Future<void> updateProfile(UserProfileModel profile) async {
    await _usersCollection.doc(profile.uid).update(
          profile.toMap(),
        );
  }

  /// Checks whether a student profile exists.
  Future<bool> profileExists(String uid) async {
    final document = await _usersCollection.doc(uid).get();

    return document.exists;
  }
}