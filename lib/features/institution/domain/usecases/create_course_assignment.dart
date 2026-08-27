import '../entities/course_assignment.dart';
import '../repositories/course_assignment_repository.dart';

final class CreateCourseAssignment {
  const CreateCourseAssignment(this._repository);

  final CourseAssignmentRepository _repository;

  Future<void> call(CourseAssignment assignment) {
    return _repository.createAssignment(assignment);
  }
}