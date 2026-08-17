class Semester {
  const Semester({
    required this.id,
    required this.institutionId,
    required this.programmeId,
    required this.levelId,
    required this.name,
    required this.order,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String programmeId;
  final String levelId;
  final String name;
  final int order;
  final bool isActive;
}