import '../entities/curriculum.dart';

abstract interface class CurriculumRepository {
  Future<void> createCurriculum(Curriculum curriculum);

  Future<List<Curriculum>> getCurriculums({
    required String institutionId,
    required String programmeId,
  });
}