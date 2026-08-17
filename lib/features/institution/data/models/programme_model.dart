import '../../domain/entities/programme.dart';

class ProgrammeModel extends Programme {
  const ProgrammeModel({
    required super.id,
    required super.institutionId,
    required super.name,
    required super.code,
    super.description,
    super.isActive,
  });

  factory ProgrammeModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return ProgrammeModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      code: map['code'] as String? ?? '',
      description: map['description'] as String?,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'name': name,
      'code': code,
      'description': description,
      'isActive': isActive,
    };
  }
}