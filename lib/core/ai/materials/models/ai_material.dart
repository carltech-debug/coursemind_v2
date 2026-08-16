enum AiMaterialType {
  pdf,
  document,
  text,
  image,
  unknown,
}

class AiMaterial {
  const AiMaterial({
    required this.id,
    required this.name,
    required this.type,
    required this.source,
    this.mimeType,
    this.metadata = const {},
  });

  final String id;
  final String name;
  final AiMaterialType type;
  final String source;
  final String? mimeType;
  final Map<String, dynamic> metadata;
}