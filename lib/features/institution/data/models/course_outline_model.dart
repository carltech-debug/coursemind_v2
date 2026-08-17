import '../../domain/entities/course_outline.dart';

class CourseOutlineModel extends CourseOutline {
  const CourseOutlineModel({
    required super.id,
    required super.institutionId,
    required super.programmeId,
    required super.levelId,
    required super.semesterId,
    required super.courseId,
    required super.title,
    required super.topics,
    super.description,
    super.version,
    super.isActive,
  });

  factory CourseOutlineModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CourseOutlineModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      levelId: map['levelId'] as String? ?? '',
      semesterId: map['semesterId'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      topics: (map['topics'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
      description: map['description'] as String?,
      version: map['version'] as int? ?? 1,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'programmeId': programmeId,
      'levelId': levelId,
      'semesterId': semesterId,
      'courseId': courseId,
      'title': title,
      'topics': topics,
      'description': description,
      'version': version,
      'isActive': isActive,
    };
  }
}