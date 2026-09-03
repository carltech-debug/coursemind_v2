import '../entities/institution.dart';

abstract interface class InstitutionRepository {
  Future<void> createInstitution(
    Institution institution,
  );

  Future<Institution?> getInstitution(
    String institutionId,
  );
}