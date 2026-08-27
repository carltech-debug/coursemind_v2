import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lecturer_model.dart';

final class LecturerFirestoreDataSource {
  LecturerFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _lecturers(
    String institutionId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('lecturers');
  }

  Future<void> createLecturer(
    LecturerModel lecturer,
  ) async {
    await _lecturers(lecturer.institutionId)
        .doc(lecturer.userId)
        .set(lecturer.toMap());
  }

  Future<List<LecturerModel>> getLecturers(
    String institutionId,
  ) async {
    final snapshot = await _lecturers(institutionId).get();

    return snapshot.docs
        .map(
          (doc) => LecturerModel.fromMap(
            doc.data(),
          ),
        )
        .toList();
  }
}