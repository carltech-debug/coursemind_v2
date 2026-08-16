//import '../errors/ai_exception.dart';
import 'academic_context.dart';

abstract interface class AcademicContextAuthorizer {
  Future<void> authorize({
    required String studentId,
    required AcademicContext context,
  });
}