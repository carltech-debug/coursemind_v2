import 'package:coursemind/core/ai/errors/ai_exception.dart';
import 'package:coursemind/core/ai/materials/ai_material_analysis_parser.dart';
import 'package:coursemind/core/ai/materials/ai_material_service.dart';
import 'package:coursemind/core/ai/materials/models/ai_material.dart';
import 'package:coursemind/development/ai/materials/dev_text_material_ingestor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Development text material can be ingested',
    () async {
      const material = AiMaterial(
        id: 'test-material',
        name: 'Engineering Mathematics',
        type: AiMaterialType.text,
        source: '''
Functions

A function is a relation between two sets in which every
element of the first set is associated with exactly one
element of the second set.
''',
      );

      const service = AiMaterialService(
        ingestor: DevTextMaterialIngestor(),
      );

      final content = await service.ingest(material);

      expect(content, isNotEmpty);
      expect(content, contains('Functions'));
      expect(content, contains('relation'));
    },
  );
  test(
  'Material analysis parser converts valid JSON',
  () {
    const response = '''
{
  "topics": [
    "Functions"
  ],
  "concepts": {
    "Functions": [
      "Domain",
      "Range",
      "Inverse functions"
    ]
  },
  "keyPoints": [
    "Every input has exactly one output."
  ],
  "learningSequence": [
    "Domain and range",
    "Function notation",
    "Inverse functions"
  ],
  "issues": []
}
''';

    final analysis = AiMaterialAnalysisParser.parse(
      materialId: 'test-material',
      response: response,
    );

    expect(analysis.materialId, 'test-material');
    expect(analysis.topics, contains('Functions'));
    expect(
      analysis.concepts['Functions'],
      contains('Domain'),
    );
    expect(
      analysis.keyPoints,
      contains('Every input has exactly one output.'),
    );
    expect(
      analysis.learningSequence,
      contains('Inverse functions'),
    );
    expect(analysis.issues, isEmpty);
  },
);
test(
  'Material analysis parser rejects invalid JSON',
  () {
    expect(
      () => AiMaterialAnalysisParser.parse(
        materialId: 'test-material',
        response: 'This is not valid JSON.',
      ),
      throwsA(isA<AiException>()),
    );
  },
);
}