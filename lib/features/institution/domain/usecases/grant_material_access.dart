import '../entities/material_access.dart';
import '../repositories/material_access_repository.dart';

final class GrantMaterialAccess {
  const GrantMaterialAccess(this._repository);

  final MaterialAccessRepository _repository;

  Future<void> call(MaterialAccess access) {
    return _repository.createAccess(access);
  }
}