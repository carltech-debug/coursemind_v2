import '../../domain/entities/programme.dart';
import '../../domain/repositories/programme_repository.dart';
import '../datasources/programme_firestore_datasource.dart';
import '../models/programme_model.dart';

final class ProgrammeRepositoryImpl
    implements ProgrammeRepository {
  ProgrammeRepositoryImpl({
    required this._dataSource,
  });

  final ProgrammeFirestoreDataSource _dataSource;

  @override
  Future<void> createProgramme(
    Programme programme,
  ) {
    return _dataSource.createProgramme(
      ProgrammeModel(
        id: programme.id,
        institutionId: programme.institutionId,
        name: programme.name,
        code: programme.code,
        description: programme.description,
        isActive: programme.isActive,
      ),
    );
  }

  @override
  Future<List<Programme>> getProgrammes(
    String institutionId,
  ) {
    return _dataSource.getProgrammes(institutionId);
  }
}