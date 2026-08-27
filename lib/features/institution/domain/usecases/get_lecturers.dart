import '../entities/lecturer.dart';
import '../repositories/lecturer_repository.dart';

final class GetLecturers {
  const GetLecturers(this._repository);

  final LecturerRepository _repository;

  Future<List<Lecturer>> call(String institutionId) {
    return _repository.getLecturers(institutionId);
  }
}