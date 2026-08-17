import '../entities/level.dart';

abstract interface class LevelRepository {
  Future<void> createLevel(Level level);

  Future<List<Level>> getLevels({
    required String institutionId,
    required String programmeId,
  });
}