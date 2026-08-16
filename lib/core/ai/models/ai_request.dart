class AiRequest {
  const AiRequest({
    required this.prompt,
    this.systemInstruction,
  });

  final String prompt;
  final String? systemInstruction;
}