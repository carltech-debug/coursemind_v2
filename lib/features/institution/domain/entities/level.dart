class Level {
  const Level({
    required this.id,
    required this.institutionId,
    required this.programmeId,
    required this.name,
    required this.order,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String programmeId;
  final String name;
  final int order;
  final bool isActive;
}