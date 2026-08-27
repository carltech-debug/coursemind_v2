import '../entities/curriculum.dart';
import '../repositories/curriculum_repository.dart';

final class GetCurriculums {
  const GetCurriculums(this._repository);

  final CurriculumRepository _repository;

  Future<List<Curriculum>> call({
    required String institutionId,
    required String programmeId,
  }) {
    return _repository.getCurriculums(
      institutionId: institutionId,
      programmeId: programmeId,
    );
  }
}