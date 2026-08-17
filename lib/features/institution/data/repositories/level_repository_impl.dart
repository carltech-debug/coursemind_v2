import '../../domain/entities/level.dart';
import '../../domain/repositories/level_repository.dart';
import '../datasources/level_firestore_datasource.dart';
import '../models/level_model.dart';

final class LevelRepositoryImpl implements LevelRepository {
  LevelRepositoryImpl({
    required this._dataSource,
  });

  final LevelFirestoreDataSource _dataSource;

  @override
  Future<void> createLevel(Level level) {
    return _dataSource.createLevel(
      LevelModel(
        id: level.id,
        institutionId: level.institutionId,
        programmeId: level.programmeId,
        name: level.name,
        order: level.order,
        isActive: level.isActive,
      ),
    );
  }

  @override
  Future<List<Level>> getLevels({
    required String institutionId,
    required String programmeId,
  }) {
    return _dataSource.getLevels(
      institutionId: institutionId,
      programmeId: programmeId,
    );
  }
}