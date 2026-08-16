import '../models/ai_request.dart';
import '../models/ai_response.dart';

abstract interface class AiProvider {
  Future<AiResponse> generate(AiRequest request);
}