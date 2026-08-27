import '../../domain/entities/course_material.dart';
import '../../domain/repositories/course_material_repository.dart';
import '../datasources/course_material_firestore_datasource.dart';
import '../models/course_material_model.dart';

final class CourseMaterialRepositoryImpl
    implements CourseMaterialRepository {
  CourseMaterialRepositoryImpl({
    required this._dataSource,
  });

  final CourseMaterialFirestoreDataSource _dataSource;

  @override
  Future<void> createCourseMaterial(
    CourseMaterial material,
  ) {
    return _dataSource.createCourseMaterial(
      CourseMaterialModel(
        id: material.id,
        institutionId: material.institutionId,
        courseId: material.courseId,
        name: material.name,
        type: material.type,
        storagePath: material.storagePath,
        description: material.description,
        isFree: material.isFree,
        isActive: material.isActive,
      ),
    );
  }

  @override
  Future<List<CourseMaterial>> getCourseMaterials({
    required String institutionId,
    required String courseId,
  }) {
    return _dataSource.getCourseMaterials(
      institutionId: institutionId,
      courseId: courseId,
    );
  }
}