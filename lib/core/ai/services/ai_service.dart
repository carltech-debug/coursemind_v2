import '../context/ai_context_service.dart';
import '../models/ai_request.dart';
import '../models/ai_response.dart';
import '../providers/ai_provider.dart';

final class AiService {
  const AiService({
    required this._provider,
    required this._contextService,
  });

  final AiProvider _provider;
  final AiContextService _contextService;

  Future<AiResponse> generate(AiRequest request) {
    return _provider.generate(request);
  }

  Future<AiResponse> generateForCourse({
    required String studentId,
    required String courseId,
    required String prompt,
    String? systemInstruction,
  }) async {
    final academicContext =
        await _contextService.getFormattedContext(
      studentId: studentId,
      courseId: courseId,
    );

    final contextualRequest = AiRequest(
      systemInstruction: systemInstruction,
      prompt: '''
COURSEMIND ACADEMIC CONTEXT

$academicContext

STUDENT REQUEST

$prompt
''',
    );

    return _provider.generate(contextualRequest);
  }
}