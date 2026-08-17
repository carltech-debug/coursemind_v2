class Programme {
  const Programme({
    required this.id,
    required this.institutionId,
    required this.name,
    required this.code,
    this.description,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String name;
  final String code;
  final String? description;
  final bool isActive;
}