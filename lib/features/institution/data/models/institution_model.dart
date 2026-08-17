import '../../domain/entities/institution.dart';

class InstitutionModel extends Institution {
  const InstitutionModel({
    required super.id,
    required super.name,
    required super.email,
    super.logoUrl,
    super.description,
    super.isActive,
  });

  factory InstitutionModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return InstitutionModel(
      id: id,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      logoUrl: map['logoUrl'] as String?,
      description: map['description'] as String?,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'logoUrl': logoUrl,
      'description': description,
      'isActive': isActive,
    };
  }
}