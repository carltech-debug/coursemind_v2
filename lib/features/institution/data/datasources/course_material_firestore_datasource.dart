import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_material_model.dart';

final class CourseMaterialFirestoreDataSource {
  CourseMaterialFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _materials(
    String institutionId,
    String courseId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('courses')
        .doc(courseId)
        .collection('materials');
  }

  Future<void> createCourseMaterial(
    CourseMaterialModel material,
  ) async {
    await _materials(
      material.institutionId,
      material.courseId,
    ).doc(material.id).set(material.toMap());
  }

  Future<List<CourseMaterialModel>> getCourseMaterials({
    required String institutionId,
    required String courseId,
  }) async {
    final snapshot = await _materials(
      institutionId,
      courseId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => CourseMaterialModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}