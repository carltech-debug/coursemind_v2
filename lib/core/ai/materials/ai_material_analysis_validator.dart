import '../errors/ai_exception.dart';
import 'models/ai_material_analysis.dart';

final class AiMaterialAnalysisValidator {
  const AiMaterialAnalysisValidator._();

  static AiMaterialAnalysis validate(
    AiMaterialAnalysis analysis,
  ) {
    if (analysis.materialId.trim().isEmpty) {
      throw const AiException(
        'Material ID is required.',
        code: 'MISSING_MATERIAL_ID',
      );
    }

    if (analysis.topics.isEmpty &&
        analysis.keyPoints.isEmpty &&
        analysis.learningSequence.isEmpty &&
        analysis.issues.isEmpty) {
      throw const AiException(
        'Material analysis contains no usable information.',
        code: 'EMPTY_MATERIAL_ANALYSIS',
      );
    }

    return analysis;
  }
}