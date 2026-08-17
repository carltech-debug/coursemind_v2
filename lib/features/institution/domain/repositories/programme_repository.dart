import '../entities/programme.dart';

abstract interface class ProgrammeRepository {
  Future<void> createProgramme(Programme programme);

  Future<List<Programme>> getProgrammes(String institutionId);
}