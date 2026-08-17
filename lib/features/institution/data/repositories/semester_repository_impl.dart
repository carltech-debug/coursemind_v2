import '../../domain/entities/semester.dart';
import '../../domain/repositories/semester_repository.dart';
import '../datasources/semester_firestore_datasource.dart';
import '../models/semester_model.dart';

final class SemesterRepositoryImpl
    implements SemesterRepository {
  SemesterRepositoryImpl({
    required this._dataSource,
  });

  final SemesterFirestoreDataSource _dataSource;

  @override
  Future<void> createSemester(Semester semester) {
    return _dataSource.createSemester(
      SemesterModel(
        id: semester.id,
        institutionId: semester.institutionId,
        programmeId: semester.programmeId,
        levelId: semester.levelId,
        name: semester.name,
        order: semester.order,
        isActive: semester.isActive,
      ),
    );
  }

  @override
  Future<List<Semester>> getSemesters({
    required String institutionId,
    required String programmeId,
    required String levelId,
  }) {
    return _dataSource.getSemesters(
      institutionId: institutionId,
      programmeId: programmeId,
      levelId: levelId,
    );
  }
}