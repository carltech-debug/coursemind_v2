import '../entities/course_material.dart';

abstract interface class CourseMaterialRepository {
  Future<void> createCourseMaterial(
    CourseMaterial material,
  );

  Future<List<CourseMaterial>> getCourseMaterials({
    required String institutionId,
    required String courseId,
  });
}