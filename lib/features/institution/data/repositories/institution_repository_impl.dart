import '../../domain/entities/institution.dart';
import '../../domain/entities/institution_admin.dart';
import '../../domain/repositories/institution_repository.dart';
import '../datasources/institution_firestore_datasource.dart';
import '../models/institution_admin_model.dart';
import '../models/institution_model.dart';

final class InstitutionRepositoryImpl
    implements InstitutionRepository {
  InstitutionRepositoryImpl({
    required this._dataSource,
  });

  final InstitutionFirestoreDataSource _dataSource;

  @override
  Future<void> createInstitution(
    Institution institution,
  ) {
    return _dataSource.createInstitution(
      InstitutionModel(
        id: institution.id,
        name: institution.name,
        email: institution.email,
        logoUrl: institution.logoUrl,
        description: institution.description,
        isActive: institution.isActive,
      ),
    );
  }

  @override
  Future<Institution?> getInstitution(
    String institutionId,
  ) {
    return _dataSource.getInstitution(institutionId);
  }

  @override
  Future<void> createAdministrator(
    InstitutionAdmin administrator,
  ) {
    return _dataSource.createAdministrator(
      InstitutionAdminModel(
        userId: administrator.userId,
        institutionId: administrator.institutionId,
        email: administrator.email,
        isActive: administrator.isActive,
      ),
    );
  }

  @override
  Future<InstitutionAdmin?> getAdministrator(
    String institutionId,
    String userId,
  ) {
    return _dataSource.getAdministrator(
      institutionId,
      userId,
    );
  }
}