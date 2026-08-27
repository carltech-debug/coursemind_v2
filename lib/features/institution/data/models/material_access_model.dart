import '../../domain/entities/material_access.dart';

class MaterialAccessModel extends MaterialAccess {
  const MaterialAccessModel({
    required super.id,
    required super.institutionId,
    required super.courseId,
    required super.materialId,
    required super.userId,
    required super.grantedAt,
    super.expiresAt,
    super.isActive,
  });

  factory MaterialAccessModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return MaterialAccessModel(
  id: id,
  institutionId: map['institutionId'] as String? ?? '',
  courseId: map['courseId'] as String? ?? '',
  materialId: map['materialId'] as String? ?? '',
  userId: map['userId'] as String? ?? '',
  grantedAt: DateTime.parse(
    map['grantedAt'] as String,
  ),
  expiresAt: map['expiresAt'] == null
      ? null
      : DateTime.parse(
          map['expiresAt'] as String,
        ),
  isActive: map['isActive'] as bool? ?? true,
);
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'courseId': courseId,
      'materialId': materialId,
      'userId': userId,
      'grantedAt': grantedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isActive': isActive,
    };
  }
}