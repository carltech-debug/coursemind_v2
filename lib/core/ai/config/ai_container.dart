import '../../../development/ai/authorization/dev_academic_context_authorizer.dart';
import '../context/ai_context_service.dart';
import '../context/firestore_academic_context_provider.dart';
import '../providers/gemini_provider.dart';
import '../services/ai_orchestrator.dart';
import '../services/ai_service.dart';

final class AiContainer {
  const AiContainer._();

  static AiService createService() {
    final contextProvider =
        FirestoreAcademicContextProvider();

    final contextService = AiContextService(
      provider: contextProvider,
      authorizer: const DevAcademicContextAuthorizer(),
    );

    return AiService(
      provider: GeminiProvider(),
      contextService: contextService,
    );
  }
  static AiOrchestrator createOrchestrator() {
    const authorizer = DevAcademicContextAuthorizer();

    return AiOrchestrator(
      aiService: createService(),
      authorizer: authorizer,
    );
  }
}