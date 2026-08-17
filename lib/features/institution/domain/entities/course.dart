class Course {
  const Course({
    required this.id,
    required this.institutionId,
    required this.programmeId,
    required this.levelId,
    required this.semesterId,
    required this.name,
    required this.code,
    this.description,
    this.creditHours,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String programmeId;
  final String levelId;
  final String semesterId;
  final String name;
  final String code;
  final String? description;
  final int? creditHours;
  final bool isActive;
}