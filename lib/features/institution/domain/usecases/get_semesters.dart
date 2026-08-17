import '../entities/semester.dart';
import '../repositories/semester_repository.dart';

final class GetSemesters {
  const GetSemesters(this._repository);

  final SemesterRepository _repository;

  Future<List<Semester>> call({
    required String institutionId,
    required String programmeId,
    required String levelId,
  }) {
    return _repository.getSemesters(
      institutionId: institutionId,
      programmeId: programmeId,
      levelId: levelId,
    );
  }
}