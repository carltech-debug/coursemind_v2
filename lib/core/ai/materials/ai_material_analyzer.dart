import '../context/academic_context.dart';
import '../models/ai_response.dart';
import 'models/ai_material.dart';

abstract interface class AiMaterialAnalyzer {
  Future<AiResponse> analyze({
    required AiMaterial material,
    required String content,
    required AcademicContext context,
  });
}