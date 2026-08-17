import '../entities/course.dart';
import '../repositories/course_repository.dart';

final class GetCourses {
  const GetCourses(this._repository);

  final CourseRepository _repository;

  Future<List<Course>> call({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
  }) {
    return _repository.getCourses(
      institutionId: institutionId,
      programmeId: programmeId,
      levelId: levelId,
      semesterId: semesterId,
    );
  }
}