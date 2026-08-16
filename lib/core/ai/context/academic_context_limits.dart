class AcademicContextLimits {
  const AcademicContextLimits._();

  static const int maxCharacters = 24000;

  static String enforce(String context) {
    final trimmed = context.trim();

    if (trimmed.length <= maxCharacters) {
      return trimmed;
    }

    return trimmed.substring(0, maxCharacters);
  }
}