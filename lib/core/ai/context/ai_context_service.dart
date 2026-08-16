import 'academic_context_authorizer.dart';
import 'academic_context_formatter.dart';
import 'academic_context_limits.dart';
import 'academic_context_provider.dart';
import 'academic_context_validator.dart';

final class AiContextService {
  const AiContextService({
    required this.provider,
    required this.authorizer,
  });

  final AcademicContextProvider provider;
  final AcademicContextAuthorizer authorizer;

  Future<String> getFormattedContext({
    required String studentId,
    required String courseId,
  }) async {
    final context = await provider.getContext(
      studentId: studentId,
      courseId: courseId,
    );

    final validatedContext =
        AcademicContextValidator.validate(context);

    await authorizer.authorize(
      studentId: studentId,
      context: validatedContext,
    );

    final formattedContext =
        AcademicContextFormatter.format(validatedContext);

    return AcademicContextLimits.enforce(formattedContext);
  }
}