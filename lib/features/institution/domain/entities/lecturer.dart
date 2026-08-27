class Lecturer {
  const Lecturer({
    required this.userId,
    required this.institutionId,
    required this.name,
    required this.email,
    this.staffId,
    this.isActive = true,
  });

  final String userId;
  final String institutionId;
  final String name;
  final String email;
  final String? staffId;
  final bool isActive;
}