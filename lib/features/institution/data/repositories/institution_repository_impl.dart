import '../../domain/entities/institution.dart';
import '../../domain/repositories/institution_repository.dart';
import '../datasources/institution_firestore_datasource.dart';
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
}