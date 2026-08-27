import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_assignment_model.dart';

final class CourseAssignmentFirestoreDataSource {
  CourseAssignmentFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _assignments(
    String institutionId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('course_assignments');
  }

  Future<void> createAssignment(
    CourseAssignmentModel assignment,
  ) async {
    await _assignments(assignment.institutionId)
        .doc(assignment.id)
        .set(assignment.toMap());
  }

  Future<List<CourseAssignmentModel>> getAssignments({
    required String institutionId,
    String? lecturerId,
    String? courseId,
  }) async {
    Query<Map<String, dynamic>> query =
        _assignments(institutionId);

    if (lecturerId != null) {
      query = query.where(
        'lecturerId',
        isEqualTo: lecturerId,
      );
    }

    if (courseId != null) {
      query = query.where(
        'courseId',
        isEqualTo: courseId,
      );
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map(
          (doc) => CourseAssignmentModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}