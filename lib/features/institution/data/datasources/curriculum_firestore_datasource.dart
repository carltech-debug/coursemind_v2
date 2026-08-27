import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/curriculum_model.dart';

final class CurriculumFirestoreDataSource {
  CurriculumFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _curriculums(
    String institutionId,
    String programmeId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .doc(programmeId)
        .collection('curriculums');
  }

  Future<void> createCurriculum(
    CurriculumModel curriculum,
  ) async {
    await _curriculums(
      curriculum.institutionId,
      curriculum.programmeId,
    ).doc(curriculum.id).set(curriculum.toMap());
  }

  Future<List<CurriculumModel>> getCurriculums({
    required String institutionId,
    required String programmeId,
  }) async {
    final snapshot = await _curriculums(
      institutionId,
      programmeId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => CurriculumModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}