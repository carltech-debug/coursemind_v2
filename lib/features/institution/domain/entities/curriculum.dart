class Curriculum {
  const Curriculum({
    required this.id,
    required this.institutionId,
    required this.programmeId,
    required this.name,
    required this.version,
    this.description,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String programmeId;
  final String name;
  final int version;
  final String? description;
  final bool isActive;
}