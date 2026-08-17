import '../../domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.institutionId,
    required super.programmeId,
    required super.levelId,
    required super.semesterId,
    required super.name,
    required super.code,
    super.description,
    super.creditHours,
    super.isActive,
  });

  factory CourseModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CourseModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      levelId: map['levelId'] as String? ?? '',
      semesterId: map['semesterId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      code: map['code'] as String? ?? '',
      description: map['description'] as String?,
      creditHours: map['creditHours'] as int?,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'programmeId': programmeId,
      'levelId': levelId,
      'semesterId': semesterId,
      'name': name,
      'code': code,
      'description': description,
      'creditHours': creditHours,
      'isActive': isActive,
    };
  }
}