import '../../domain/entities/level.dart';

class LevelModel extends Level {
  const LevelModel({
    required super.id,
    required super.institutionId,
    required super.programmeId,
    required super.name,
    required super.order,
    super.isActive,
  });

  factory LevelModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return LevelModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      order: map['order'] as int? ?? 0,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'programmeId': programmeId,
      'name': name,
      'order': order,
      'isActive': isActive,
    };
  }
}