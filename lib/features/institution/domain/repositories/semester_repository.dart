import '../entities/semester.dart';

abstract interface class SemesterRepository {
  Future<void> createSemester(Semester semester);

  Future<List<Semester>> getSemesters({
    required String institutionId,
    required String programmeId,
    required String levelId,
  });
}