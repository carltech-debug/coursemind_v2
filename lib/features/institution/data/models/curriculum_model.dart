import '../../domain/entities/curriculum.dart';

class CurriculumModel extends Curriculum {
  const CurriculumModel({
    required super.id,
    required super.institutionId,
    required super.programmeId,
    required super.name,
    required super.version,
    super.description,
    super.isActive,
  });

  factory CurriculumModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CurriculumModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      version: map['version'] as int? ?? 1,
      description: map['description'] as String?,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'programmeId': programmeId,
      'name': name,
      'version': version,
      'description': description,
      'isActive': isActive,
    };
  }
}