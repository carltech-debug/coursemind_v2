import 'academic_context.dart';
import 'academic_context_authorizer.dart';

final class DevAcademicContextAuthorizer
    implements AcademicContextAuthorizer {
  const DevAcademicContextAuthorizer();

  @override
  Future<void> authorize({
    required String studentId,
    required AcademicContext context,
  }) async {
    if (studentId.trim().isEmpty) {
      throw StateError('Student ID is required.');
    }
  }
}