import '../entities/material_file.dart';

abstract interface class MaterialStorageRepository {
  Future<MaterialFile> uploadMaterial({
    required String institutionId,
    required String courseId,
    required String materialId,
    required String fileName,
    required String contentType,
    required List<int> bytes,
  });

  Future<void> deleteMaterial({
    required String storagePath,
  });
}