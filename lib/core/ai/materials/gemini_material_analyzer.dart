import '../context/academic_context.dart';
import '../models/ai_request.dart';
import '../models/ai_response.dart';
import '../prompts/ai_prompts.dart';
import '../providers/ai_provider.dart';
import 'ai_material_analyzer.dart';
import 'models/ai_material.dart';

final class GeminiMaterialAnalyzer implements AiMaterialAnalyzer {
  const GeminiMaterialAnalyzer({
    required this.provider,
  });

  final AiProvider provider;

  @override
  Future<AiResponse> analyze({
    required AiMaterial material,
    required String content,
    required AcademicContext context,
  }) {
    final prompt = '''
    Analyze the following academic material for CourseMind.

    ACADEMIC CONTEXT
    Institution: ${context.institution ?? 'Unknown'}
    Programme: ${context.programme ?? 'Unknown'}
    Level: ${context.level ?? 'Unknown'}
    Semester: ${context.semester ?? 'Unknown'}
    Course: ${context.course ?? 'Unknown'}

    MATERIAL
    Name: ${material.name}
    Type: ${material.type.name}

    CONTENT
    $content

    TASK
    Analyze only the information explicitly supported by the material.

    Identify:
    1. The major topics covered.
    2. The concepts taught under each topic.
    3. Important definitions, principles, formulas, or procedures.
    4. The apparent learning sequence.
    5. Content that appears unclear, incomplete, or inconsistent.

    RULES
    - Do not invent missing material.
    - Do not assume information that is not present.
    - Clearly identify uncertainty.
    - Keep the analysis academically precise.
    - Return ONLY valid JSON.
    - Do not use Markdown.
    - Do not wrap the JSON in ```json or ```.

    RETURN EXACTLY THIS JSON STRUCTURE:

    {
      "topics": [
        "topic name"
      ],
      "concepts": {
        "topic name": [
          "concept 1",
          "concept 2"
        ]
      },
      "keyPoints": [
        "key point"
      ],
      "learningSequence": [
        "first topic",
        "second topic"
      ],
      "issues": [
        "issue or uncertainty"
      ]
    }
    ''';

    return provider.generate(
      AiRequest(
        systemInstruction: AiPrompts.baseSystemInstruction,
        prompt: prompt,
      ),
    );
  }
}