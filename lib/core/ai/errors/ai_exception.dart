class AiException implements Exception {
  const AiException(
    this.message, {
    this.code,
    this.cause,
  });

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() {
    if (code == null) {
      return message;
    }

    return '$code: $message';
  }
}