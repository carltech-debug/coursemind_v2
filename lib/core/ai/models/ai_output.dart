class AiOutput {
  const AiOutput({
    required this.text,
    this.metadata = const {},
  });

  final String text;
  final Map<String, dynamic> metadata;
}