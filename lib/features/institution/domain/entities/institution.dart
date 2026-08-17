class Institution {
  const Institution({
    required this.id,
    required this.name,
    required this.email,
    this.logoUrl,
    this.description,
    this.isActive = true,
  });

  final String id;
  final String name;
  final String email;
  final String? logoUrl;
  final String? description;
  final bool isActive;
}