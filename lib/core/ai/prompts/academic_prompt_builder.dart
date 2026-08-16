import '../context/academic_context.dart';
import '../context/academic_context_formatter.dart';
import 'ai_prompts.dart';

class AcademicPromptBuilder {
  const AcademicPromptBuilder._();

  static String build({
    required AcademicContext context,
    required String studentRequest,
  }) {
    final academicContext =
        AcademicContextFormatter.format(context);

    return '''
${AiPrompts.baseSystemInstruction}

Use the following CourseMind academic context:

$academicContext

Student request:
$studentRequest
''';
  }
}