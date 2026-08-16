import '../providers/gemini_provider.dart';
import 'ai_material_analysis_service.dart';
import 'ai_material_service.dart';
import 'dev_text_material_ingestor.dart';
import 'gemini_material_analyzer.dart';

final class AiMaterialContainer {
  const AiMaterialContainer._();

  static AiMaterialAnalysisService createAnalysisService() {
    const materialService = AiMaterialService(
      ingestor: DevTextMaterialIngestor(),
    );

    final analyzer = GeminiMaterialAnalyzer(
      provider: GeminiProvider(),
    );

    return AiMaterialAnalysisService(
      materialService: materialService,
      analyzer: analyzer,
    );
  }
}