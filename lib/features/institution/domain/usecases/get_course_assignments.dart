import '../entities/course_assignment.dart';
import '../repositories/course_assignment_repository.dart';

final class GetCourseAssignments {
  const GetCourseAssignments(this._repository);

  final CourseAssignmentRepository _repository;

  Future<List<CourseAssignment>> call({
    required String institutionId,
    String? lecturerId,
    String? courseId,
  }) {
    return _repository.getAssignments(
      institutionId: institutionId,
      lecturerId: lecturerId,
      courseId: courseId,
    );
  }
}