import '../entities/material_access.dart';
import '../repositories/material_access_repository.dart';

final class GetMaterialAccess {
  const GetMaterialAccess(this._repository);

  final MaterialAccessRepository _repository;

  Future<List<MaterialAccess>> call({
    required String institutionId,
    required String courseId,
    required String materialId,
    String? userId,
  }) {
    return _repository.getAccessRecords(
      institutionId: institutionId,
      courseId: courseId,
      materialId: materialId,
      userId: userId,
    );
  }
}