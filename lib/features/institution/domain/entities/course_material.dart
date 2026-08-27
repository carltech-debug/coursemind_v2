class CourseMaterial {
  const CourseMaterial({
    required this.id,
    required this.institutionId,
    required this.courseId,
    required this.name,
    required this.type,
    required this.storagePath,
    this.description,
    this.isFree = true,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String courseId;
  final String name;
  final String type;
  final String storagePath;
  final String? description;
  final bool isFree;
  final bool isActive;
}