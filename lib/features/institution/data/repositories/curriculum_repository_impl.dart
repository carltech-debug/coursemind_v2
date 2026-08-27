import '../../domain/entities/curriculum.dart';
import '../../domain/repositories/curriculum_repository.dart';
import '../datasources/curriculum_firestore_datasource.dart';
import '../models/curriculum_model.dart';

final class CurriculumRepositoryImpl
    implements CurriculumRepository {
  CurriculumRepositoryImpl({
    required this._dataSource,
  });

  final CurriculumFirestoreDataSource _dataSource;

  @override
  Future<void> createCurriculum(Curriculum curriculum) {
    return _dataSource.createCurriculum(
      CurriculumModel(
        id: curriculum.id,
        institutionId: curriculum.institutionId,
        programmeId: curriculum.programmeId,
        name: curriculum.name,
        version: curriculum.version,
        description: curriculum.description,
        isActive: curriculum.isActive,
      ),
    );
  }

  @override
  Future<List<Curriculum>> getCurriculums({
    required String institutionId,
    required String programmeId,
  }) {
    return _dataSource.getCurriculums(
      institutionId: institutionId,
      programmeId: programmeId,
    );
  }
}