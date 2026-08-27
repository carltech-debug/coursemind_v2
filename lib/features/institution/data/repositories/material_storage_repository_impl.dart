import '../../domain/entities/material_file.dart';
import '../../domain/repositories/material_storage_repository.dart';

final class MaterialStorageRepositoryImpl
    implements MaterialStorageRepository {
  const MaterialStorageRepositoryImpl();

  @override
  Future<MaterialFile> uploadMaterial({
    required String institutionId,
    required String courseId,
    required String materialId,
    required String fileName,
    required String contentType,
    required List<int> bytes,
  }) {
    throw UnimplementedError(
      'Material storage provider has not been connected yet.',
    );
  }

  @override
  Future<void> deleteMaterial({
    required String storagePath,
  }) {
    throw UnimplementedError(
      'Material storage provider has not been connected yet.',
    );
  }
}