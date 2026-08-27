import '../../domain/entities/lecturer.dart';
import '../../domain/repositories/lecturer_repository.dart';
import '../datasources/lecturer_firestore_datasource.dart';
import '../models/lecturer_model.dart';

final class LecturerRepositoryImpl implements LecturerRepository {
  LecturerRepositoryImpl({
    required this._dataSource,
  });

  final LecturerFirestoreDataSource _dataSource;

  @override
  Future<void> createLecturer(Lecturer lecturer) {
    return _dataSource.createLecturer(
      LecturerModel(
        userId: lecturer.userId,
        institutionId: lecturer.institutionId,
        name: lecturer.name,
        email: lecturer.email,
        staffId: lecturer.staffId,
        isActive: lecturer.isActive,
      ),
    );
  }

  @override
  Future<List<Lecturer>> getLecturers(
    String institutionId,
  ) {
    return _dataSource.getLecturers(institutionId);
  }
}