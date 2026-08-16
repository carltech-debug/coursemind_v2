import 'dart:convert';

import '../errors/ai_exception.dart';
import 'models/ai_material_analysis.dart';

final class AiMaterialAnalysisParser {
  const AiMaterialAnalysisParser._();

  static AiMaterialAnalysis parse({
    required String materialId,
    required String response,
  }) {
    final text = response.trim();

    if (text.isEmpty) {
      throw const AiException(
        'Material analysis response is empty.',
        code: 'EMPTY_MATERIAL_ANALYSIS',
      );
    }

    try {
      final decoded = jsonDecode(text);

      if (decoded is! Map<String, dynamic>) {
        throw const AiException(
          'Material analysis response must be a JSON object.',
          code: 'INVALID_MATERIAL_ANALYSIS_FORMAT',
        );
      }

      return AiMaterialAnalysis(
        materialId: materialId,
        topics: _stringList(decoded['topics']),
        concepts: _conceptMap(decoded['concepts']),
        keyPoints: _stringList(decoded['keyPoints']),
        learningSequence: _stringList(
          decoded['learningSequence'],
        ),
        issues: _stringList(decoded['issues']),
      );
    } on AiException {
      rethrow;
    } on FormatException {
      throw const AiException(
        'Material analysis response is not valid JSON.',
        code: 'INVALID_MATERIAL_ANALYSIS_JSON',
      );
    }
  }

  static List<String> _stringList(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<String>()
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  static Map<String, List<String>> _conceptMap(Object? value) {
    if (value is! Map) {
      return const {};
    }

    final result = <String, List<String>>{};

    for (final entry in value.entries) {
      final key = entry.key.toString().trim();

      if (key.isEmpty) {
        continue;
      }

      result[key] = _stringList(entry.value);
    }

    return result;
  }
}