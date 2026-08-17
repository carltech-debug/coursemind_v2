import '../entities/institution.dart';
import '../repositories/institution_repository.dart';

final class GetInstitution {
  const GetInstitution(this._repository);

  final InstitutionRepository _repository;

  Future<Institution?> call(String institutionId) {
    return _repository.getInstitution(institutionId);
  }
}