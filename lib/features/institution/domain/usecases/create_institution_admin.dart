import '../entities/institution_admin.dart';
import '../repositories/institution_repository.dart';

final class CreateInstitutionAdmin {
  const CreateInstitutionAdmin(this._repository);

  final InstitutionRepository _repository;

  Future<void> call(InstitutionAdmin administrator) {
    return _repository.createAdministrator(administrator);
  }
}