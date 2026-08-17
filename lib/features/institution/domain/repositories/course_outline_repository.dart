import '../entities/course_outline.dart';

abstract interface class CourseOutlineRepository {
  Future<void> createCourseOutline(
    CourseOutline outline,
  );

  Future<List<CourseOutline>> getCourseOutlines({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
    required String courseId,
  });
}