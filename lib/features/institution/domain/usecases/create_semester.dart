import '../entities/semester.dart';
import '../repositories/semester_repository.dart';

final class CreateSemester {
  const CreateSemester(this._repository);

  final SemesterRepository _repository;

  Future<void> call(Semester semester) {
    return _repository.createSemester(semester);
  }
}