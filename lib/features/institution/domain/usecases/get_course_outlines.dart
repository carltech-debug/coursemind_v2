import '../entities/course_outline.dart';
import '../repositories/course_outline_repository.dart';

final class GetCourseOutlines {
  const GetCourseOutlines(this._repository);

  final CourseOutlineRepository _repository;

  Future<List<CourseOutline>> call({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
    required String courseId,
  }) {
    return _repository.getCourseOutlines(
      institutionId: institutionId,
      programmeId: programmeId,
      levelId: levelId,
      semesterId: semesterId,
      courseId: courseId,
    );
  }
}