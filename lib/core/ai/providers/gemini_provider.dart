import 'package:firebase_ai/firebase_ai.dart';

import '../config/ai_config.dart';
import '../errors/ai_exception.dart';
import '../models/ai_request.dart';
import '../models/ai_response.dart';
import 'ai_provider.dart';

final class GeminiProvider implements AiProvider {
  GeminiProvider()
      : _model = FirebaseAI.googleAI().generativeModel(
          model: AiConfig.modelName,
          generationConfig: GenerationConfig(
            temperature: AiConfig.temperature,
            maxOutputTokens: AiConfig.maxOutputTokens,
          ),
        );

  final GenerativeModel _model;

  @override
  Future<AiResponse> generate(AiRequest request) async {
    try {
      final contents = <Content>[
        Content.text(
          request.systemInstruction == null
              ? request.prompt
              : '${request.systemInstruction}\n\n${request.prompt}',
        ),
      ];

      final response = await _model.generateContent(contents);

      final text = response.text;

      if (text == null || text.trim().isEmpty) {
        throw const AiException(
          'AI returned an empty response.',
          code: 'EMPTY_RESPONSE',
        );
      }

      return AiResponse(
        text: text.trim(),
      );
    } catch (error) {
      if (error is AiException) {
        rethrow;
      }

      throw AiException(
        'Unable to generate an AI response: $error',
        code: 'GENERATION_FAILED',
        cause: error,
      );
    }
  }
}