import '../entities/material_access.dart';

abstract interface class MaterialAccessRepository {
  Future<void> createAccess(
    MaterialAccess access,
  );

  Future<List<MaterialAccess>> getAccessRecords({
    required String institutionId,
    required String courseId,
    required String materialId,
    String? userId,
  });
}