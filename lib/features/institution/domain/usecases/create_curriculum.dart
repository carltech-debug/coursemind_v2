import '../entities/curriculum.dart';
import '../repositories/curriculum_repository.dart';

final class CreateCurriculum {
  const CreateCurriculum(this._repository);

  final CurriculumRepository _repository;

  Future<void> call(Curriculum curriculum) {
    return _repository.createCurriculum(curriculum);
  }
}