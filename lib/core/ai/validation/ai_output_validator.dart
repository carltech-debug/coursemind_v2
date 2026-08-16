import '../errors/ai_exception.dart';
import '../models/ai_output.dart';

class AiOutputValidator {
  const AiOutputValidator._();

  static AiOutput validate(AiOutput output) {
    final text = output.text.trim();

    if (text.isEmpty) {
      throw const AiException(
        'AI output is empty.',
        code: 'INVALID_OUTPUT',
      );
    }

    return AiOutput(
      text: text,
      metadata: output.metadata,
    );
  }
}