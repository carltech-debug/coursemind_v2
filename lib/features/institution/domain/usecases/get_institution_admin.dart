import '../entities/institution_admin.dart';
import '../repositories/institution_repository.dart';

final class GetInstitutionAdmin {
  const GetInstitutionAdmin(this._repository);

  final InstitutionRepository _repository;

  Future<InstitutionAdmin?> call({
    required String institutionId,
    required String userId,
  }) {
    return _repository.getAdministrator(
      institutionId,
      userId,
    );
  }
}