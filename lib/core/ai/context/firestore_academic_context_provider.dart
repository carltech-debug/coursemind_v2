import 'package:cloud_firestore/cloud_firestore.dart';

import 'academic_context.dart';
import 'academic_context_provider.dart';

final class FirestoreAcademicContextProvider
    implements AcademicContextProvider {
  FirestoreAcademicContextProvider({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<AcademicContext> getContext({
    required String studentId,
    required String courseId,
  }) async {
    final studentSnapshot =
        await _firestore.collection('users').doc(studentId).get();

    if (!studentSnapshot.exists || studentSnapshot.data() == null) {
      throw StateError('Student profile not found.');
    }

    final student = studentSnapshot.data()!;

    final courseSnapshot =
        await _firestore.collection('courses').doc(courseId).get();

    if (!courseSnapshot.exists || courseSnapshot.data() == null) {
      throw StateError('Course not found.');
    }

    final course = courseSnapshot.data()!;

    return AcademicContext(
      institution: student['institutionName'] as String?,
      programme: student['programmeName'] as String?,
      level: student['academicLevel'] as String?,
      semester: course['semesterName'] as String?,
      course: course['name'] as String?,
      courseOutline: course['courseOutline'] as String?,
    );
  }
}