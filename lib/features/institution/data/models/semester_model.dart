import '../../domain/entities/semester.dart';

class SemesterModel extends Semester {
  const SemesterModel({
    required super.id,
    required super.institutionId,
    required super.programmeId,
    required super.levelId,
    required super.name,
    required super.order,
    super.isActive,
  });

  factory SemesterModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return SemesterModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      levelId: map['levelId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      order: map['order'] as int? ?? 0,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'programmeId': programmeId,
      'levelId': levelId,
      'name': name,
      'order': order,
      'isActive': isActive,
    };
  }
}