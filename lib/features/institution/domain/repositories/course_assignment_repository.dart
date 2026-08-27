import '../entities/course_assignment.dart';

abstract interface class CourseAssignmentRepository {
  Future<void> createAssignment(
    CourseAssignment assignment,
  );

  Future<List<CourseAssignment>> getAssignments({
    required String institutionId,
    String? lecturerId,
    String? courseId,
  });
}