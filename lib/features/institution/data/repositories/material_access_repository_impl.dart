import '../../domain/entities/material_access.dart';
import '../../domain/repositories/material_access_repository.dart';
import '../datasources/material_access_firestore_datasource.dart';
import '../models/material_access_model.dart';

final class MaterialAccessRepositoryImpl
    implements MaterialAccessRepository {
  MaterialAccessRepositoryImpl({
    required this._dataSource,
  });

  final MaterialAccessFirestoreDataSource _dataSource;

  @override
  Future<void> createAccess(
    MaterialAccess access,
  ) {
    return _dataSource.createAccess(
      MaterialAccessModel(
        id: access.id,
        institutionId: access.institutionId,
        courseId: access.courseId,
        materialId: access.materialId,
        userId: access.userId,
        grantedAt: access.grantedAt,
        expiresAt: access.expiresAt,
        isActive: access.isActive,
      ),
    );
  }

  @override
  Future<List<MaterialAccess>> getAccessRecords({
    required String institutionId,
    required String courseId,
    required String materialId,
    String? userId,
  }) {
    return _dataSource.getAccessRecords(
      institutionId: institutionId,
      courseId: courseId,
      materialId: materialId,
      userId: userId,
    );
  }
}