import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_outline_model.dart';

final class CourseOutlineFirestoreDataSource {
  CourseOutlineFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _outlines(
    String institutionId,
    String programmeId,
    String levelId,
    String semesterId,
    String courseId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .doc(programmeId)
        .collection('levels')
        .doc(levelId)
        .collection('semesters')
        .doc(semesterId)
        .collection('courses')
        .doc(courseId)
        .collection('outlines');
  }

  Future<void> createCourseOutline(
    CourseOutlineModel outline,
  ) async {
    await _outlines(
      outline.institutionId,
      outline.programmeId,
      outline.levelId,
      outline.semesterId,
      outline.courseId,
    ).doc(outline.id).set(outline.toMap());
  }

  Future<List<CourseOutlineModel>> getCourseOutlines({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
    required String courseId,
  }) async {
    final snapshot = await _outlines(
      institutionId,
      programmeId,
      levelId,
      semesterId,
      courseId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => CourseOutlineModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}