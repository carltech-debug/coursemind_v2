import '../../domain/entities/course_assignment.dart';

class CourseAssignmentModel extends CourseAssignment {
  const CourseAssignmentModel({
    required super.id,
    required super.institutionId,
    required super.lecturerId,
    required super.courseId,
    required super.assignedAt,
    super.isActive,
  });

  factory CourseAssignmentModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CourseAssignmentModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      lecturerId: map['lecturerId'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      assignedAt: DateTime.parse(
        map['assignedAt'] as String,
      ),
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'lecturerId': lecturerId,
      'courseId': courseId,
      'assignedAt': assignedAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}