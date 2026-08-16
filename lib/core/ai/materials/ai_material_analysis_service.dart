import '../context/academic_context.dart';
import '../models/ai_response.dart';
import 'ai_material_analysis_parser.dart';
import 'ai_material_analysis_validator.dart';
import 'ai_material_analyzer.dart';
import 'ai_material_service.dart';
import 'models/ai_material.dart';
import 'models/ai_material_analysis.dart';

final class AiMaterialAnalysisService {
  const AiMaterialAnalysisService({
    required this.materialService,
    required this.analyzer,
  });

  final AiMaterialService materialService;
  final AiMaterialAnalyzer analyzer;

  Future<AiMaterialAnalysis> analyze({
    required AiMaterial material,
    required AcademicContext context,
  }) async {
    final content = await materialService.ingest(material);

    final AiResponse response = await analyzer.analyze(
      material: material,
      content: content,
      context: context,
    );

    final analysis = AiMaterialAnalysisParser.parse(
  materialId: material.id,
  response: response.text,
);

return AiMaterialAnalysisValidator.validate(analysis);
  }
}