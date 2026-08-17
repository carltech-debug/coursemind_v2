import '../entities/level.dart';
import '../repositories/level_repository.dart';

final class CreateLevel {
  const CreateLevel(this._repository);

  final LevelRepository _repository;

  Future<void> call(Level level) {
    return _repository.createLevel(level);
  }
}