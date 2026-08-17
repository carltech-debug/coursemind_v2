import '../entities/programme.dart';
import '../repositories/programme_repository.dart';

final class CreateProgramme {
  const CreateProgramme(this._repository);

  final ProgrammeRepository _repository;

  Future<void> call(Programme programme) {
    return _repository.createProgramme(programme);
  }
}