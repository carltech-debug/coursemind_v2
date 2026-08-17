import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';

final class CourseFirestoreDataSource {
  CourseFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _courses(
    String institutionId,
    String programmeId,
    String levelId,
    String semesterId,
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
        .collection('courses');
  }

  Future<void> createCourse(
    CourseModel course,
  ) async {
    await _courses(
      course.institutionId,
      course.programmeId,
      course.levelId,
      course.semesterId,
    ).doc(course.id).set(course.toMap());
  }

  Future<List<CourseModel>> getCourses({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
  }) async {
    final snapshot = await _courses(
      institutionId,
      programmeId,
      levelId,
      semesterId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => CourseModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}