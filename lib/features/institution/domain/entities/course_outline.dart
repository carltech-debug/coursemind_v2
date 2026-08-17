class CourseOutline {
  const CourseOutline({
    required this.id,
    required this.institutionId,
    required this.programmeId,
    required this.levelId,
    required this.semesterId,
    required this.courseId,
    required this.title,
    required this.topics,
    this.description,
    this.version = 1,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String programmeId;
  final String levelId;
  final String semesterId;
  final String courseId;
  final String title;
  final List<String> topics;
  final String? description;
  final int version;
  final bool isActive;
}