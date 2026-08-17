import '../entities/institution.dart';
import '../repositories/institution_repository.dart';

final class CreateInstitution {
  const CreateInstitution(this._repository);

  final InstitutionRepository _repository;

  Future<void> call(Institution institution) {
    return _repository.createInstitution(institution);
  }
}