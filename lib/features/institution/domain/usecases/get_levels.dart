import '../entities/level.dart';
import '../repositories/level_repository.dart';

final class GetLevels {
  const GetLevels(this._repository);

  final LevelRepository _repository;

  Future<List<Level>> call({
    required String institutionId,
    required String programmeId,
  }) {
    return _repository.getLevels(
      institutionId: institutionId,
      programmeId: programmeId,
    );
  }
}