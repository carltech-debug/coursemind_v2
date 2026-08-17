import '../entities/course.dart';

abstract interface class CourseRepository {
  Future<void> createCourse(Course course);

  Future<List<Course>> getCourses({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
  });
}