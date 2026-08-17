import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/semester_model.dart';

final class SemesterFirestoreDataSource {
  SemesterFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _semesters(
    String institutionId,
    String programmeId,
    String levelId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .doc(programmeId)
        .collection('levels')
        .doc(levelId)
        .collection('semesters');
  }

  Future<void> createSemester(
    SemesterModel semester,
  ) async {
    await _semesters(
      semester.institutionId,
      semester.programmeId,
      semester.levelId,
    ).doc(semester.id).set(semester.toMap());
  }

  Future<List<SemesterModel>> getSemesters({
    required String institutionId,
    required String programmeId,
    required String levelId,
  }) async {
    final snapshot = await _semesters(
      institutionId,
      programmeId,
      levelId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => SemesterModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}