import '../entities/course_material.dart';
import '../repositories/course_material_repository.dart';

final class CreateCourseMaterial {
  const CreateCourseMaterial(this._repository);

  final CourseMaterialRepository _repository;

  Future<void> call(CourseMaterial material) {
    return _repository.createCourseMaterial(material);
  }
}