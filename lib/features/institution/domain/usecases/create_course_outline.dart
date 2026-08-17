import '../entities/course_outline.dart';
import '../repositories/course_outline_repository.dart';

final class CreateCourseOutline {
  const CreateCourseOutline(this._repository);

  final CourseOutlineRepository _repository;

  Future<void> call(CourseOutline outline) {
    return _repository.createCourseOutline(outline);
  }
}