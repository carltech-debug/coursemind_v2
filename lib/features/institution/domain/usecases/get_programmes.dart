import '../entities/programme.dart';
import '../repositories/programme_repository.dart';

final class GetProgrammes {
  const GetProgrammes(this._repository);

  final ProgrammeRepository _repository;

  Future<List<Programme>> call(String institutionId) {
    return _repository.getProgrammes(institutionId);
  }
}