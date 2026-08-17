import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/level_model.dart';

final class LevelFirestoreDataSource {
  LevelFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _levels(
    String institutionId,
    String programmeId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .doc(programmeId)
        .collection('levels');
  }

  Future<void> createLevel(
    LevelModel level,
  ) async {
    await _levels(
      level.institutionId,
      level.programmeId,
    ).doc(level.id).set(level.toMap());
  }

  Future<List<LevelModel>> getLevels({
    required String institutionId,
    required String programmeId,
  }) async {
    final snapshot = await _levels(
      institutionId,
      programmeId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => LevelModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}