class AiMaterialAnalysis {
  const AiMaterialAnalysis({
    required this.materialId,
    required this.topics,
    required this.concepts,
    required this.keyPoints,
    required this.learningSequence,
    required this.issues,
  });

  final String materialId;
  final List<String> topics;
  final Map<String, List<String>> concepts;
  final List<String> keyPoints;
  final List<String> learningSequence;
  final List<String> issues;
}