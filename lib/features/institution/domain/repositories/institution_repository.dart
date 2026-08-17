import '../entities/institution.dart';
import '../entities/institution_admin.dart';

abstract interface class InstitutionRepository {
  Future<void> createInstitution(Institution institution);

  Future<Institution?> getInstitution(String institutionId);

  Future<void> createAdministrator(
    InstitutionAdmin administrator,
  );

  Future<InstitutionAdmin?> getAdministrator(
    String institutionId,
    String userId,
  );
}