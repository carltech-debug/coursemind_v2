import '../context/academic_context.dart';
import '../context/academic_context_authorizer.dart';
import '../context/academic_context_validator.dart';
import '../models/ai_request.dart';
import '../models/ai_response.dart';
import '../prompts/academic_prompt_builder.dart';
import 'ai_service.dart';

final class AiOrchestrator {
  const AiOrchestrator({
    required this.aiService,
    required this.authorizer,
  });

  final AiService aiService;
  final AcademicContextAuthorizer authorizer;

  Future<AiResponse> generateAcademicResponse({
    required String studentId,
    required AcademicContext context,
    required String studentRequest,
  }) async {
    final validatedContext =
        AcademicContextValidator.validate(context);

    await authorizer.authorize(
      studentId: studentId,
      context: validatedContext,
    );

    final prompt = AcademicPromptBuilder.build(
      context: validatedContext,
      studentRequest: studentRequest,
    );

    return aiService.generate(
      AiRequest(
        systemInstruction: null,
        prompt: prompt,
      ),
    );
  }
}