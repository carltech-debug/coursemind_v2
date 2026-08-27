import '../entities/lecturer.dart';
import '../repositories/lecturer_repository.dart';

final class CreateLecturer {
  const CreateLecturer(this._repository);

  final LecturerRepository _repository;

  Future<void> call(Lecturer lecturer) {
    return _repository.createLecturer(lecturer);
  }
}