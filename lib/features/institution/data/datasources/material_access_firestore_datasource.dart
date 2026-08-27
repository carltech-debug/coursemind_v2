import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/material_access_model.dart';

final class MaterialAccessFirestoreDataSource {
  MaterialAccessFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

    CollectionReference<Map<String, dynamic>> _accessRecords({
    required String institutionId,
    required String courseId,
    required String materialId,
  }) 
  {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('courses')
        .doc(courseId)
        .collection('materials')
        .doc(materialId)
        .collection('access');
  }

  Future<void> createAccess(
    MaterialAccessModel access,
  ) async {
    await _accessRecords(
      institutionId: access.institutionId,
      courseId: access.courseId,
      materialId: access.materialId,
    )
        .doc(access.id)
        .set(access.toMap());
  }

  Future<List<MaterialAccessModel>> getAccessRecords({
    required String institutionId,
    required String courseId,
    required String materialId,
    String? userId,
  }) async {
    Query<Map<String, dynamic>> query = _accessRecords(
      institutionId: institutionId,
      courseId: courseId,
      materialId: materialId,
    );

    if (userId != null) {
      query = query.where(
        'userId',
        isEqualTo: userId,
      );
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map(
          (doc) => MaterialAccessModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}