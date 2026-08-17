class InstitutionAdmin {
  const InstitutionAdmin({
    required this.userId,
    required this.institutionId,
    required this.email,
    required this.isActive,
  });

  final String userId;
  final String institutionId;
  final String email;
  final bool isActive;
}