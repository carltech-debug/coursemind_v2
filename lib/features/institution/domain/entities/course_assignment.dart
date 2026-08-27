class CourseAssignment {
  const CourseAssignment({
    required this.id,
    required this.institutionId,
    required this.lecturerId,
    required this.courseId,
    required this.assignedAt,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String lecturerId;
  final String courseId;
  final DateTime assignedAt;
  final bool isActive;
}