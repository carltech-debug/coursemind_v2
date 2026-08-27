class MaterialAccess {
  const MaterialAccess({
    required this.id,
    required this.institutionId,
    required this.courseId,
    required this.materialId,
    required this.userId,
    required this.grantedAt,
    this.expiresAt,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String courseId;
  final String materialId;
  final String userId;
  final DateTime grantedAt;
  final DateTime? expiresAt;
  final bool isActive;
}