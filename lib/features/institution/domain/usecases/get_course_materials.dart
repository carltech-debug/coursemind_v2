import '../entities/course_material.dart';
import '../repositories/course_material_repository.dart';

final class GetCourseMaterials {
  const GetCourseMaterials(this._repository);

  final CourseMaterialRepository _repository;

  Future<List<CourseMaterial>> call({
    required String institutionId,
    required String courseId,
  }) {
    return _repository.getCourseMaterials(
      institutionId: institutionId,
      courseId: courseId,
    );
  }
}