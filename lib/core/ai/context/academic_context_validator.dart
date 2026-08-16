import '../errors/ai_exception.dart';
import 'academic_context.dart';

class AcademicContextValidator {
  const AcademicContextValidator._();

  static AcademicContext validate(AcademicContext context) {
    if (_isEmpty(context.institution)) {
      throw const AiException(
        'Institution is required in the academic context.',
        code: 'MISSING_INSTITUTION',
      );
    }

    if (_isEmpty(context.programme)) {
      throw const AiException(
        'Programme is required in the academic context.',
        code: 'MISSING_PROGRAMME',
      );
    }

    if (_isEmpty(context.level)) {
      throw const AiException(
        'Academic level is required in the academic context.',
        code: 'MISSING_LEVEL',
      );
    }

    if (_isEmpty(context.course)) {
      throw const AiException(
        'Course is required in the academic context.',
        code: 'MISSING_COURSE',
      );
    }

    return context;
  }

  static bool _isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }
}