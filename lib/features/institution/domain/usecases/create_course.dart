import '../entities/course.dart';
import '../repositories/course_repository.dart';

final class CreateCourse {
  const CreateCourse(this._repository);

  final CourseRepository _repository;

  Future<void> call(Course course) {
    return _repository.createCourse(course);
  }
}