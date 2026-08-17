import '../../domain/entities/institution_admin.dart';

class InstitutionAdminModel extends InstitutionAdmin {
  const InstitutionAdminModel({
    required super.userId,
    required super.institutionId,
    required super.email,
    required super.isActive,
  });

  factory InstitutionAdminModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return InstitutionAdminModel(
      userId: map['userId'] as String? ?? '',
      institutionId: map['institutionId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'institutionId': institutionId,
      'email': email,
      'isActive': isActive,
    };
  }
}