import '../../domain/entities/course_material.dart';

class CourseMaterialModel extends CourseMaterial {
  const CourseMaterialModel({
    required super.id,
    required super.institutionId,
    required super.courseId,
    required super.name,
    required super.type,
    required super.storagePath,
    super.description,
    super.isFree,
    super.isActive,
  });

  factory CourseMaterialModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CourseMaterialModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      type: map['type'] as String? ?? '',
      storagePath: map['storagePath'] as String? ?? '',
      description: map['description'] as String?,
      isFree: map['isFree'] as bool? ?? true,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'courseId': courseId,
      'name': name,
      'type': type,
      'storagePath': storagePath,
      'description': description,
      'isFree': isFree,
      'isActive': isActive,
    };
  }
}