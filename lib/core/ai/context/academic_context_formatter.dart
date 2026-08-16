import 'academic_context.dart';

class AcademicContextFormatter {
  const AcademicContextFormatter._();

  static String format(AcademicContext context) {
    final buffer = StringBuffer();

    buffer.writeln('COURSEMIND ACADEMIC CONTEXT');
    buffer.writeln();

    _add(buffer, 'Institution', context.institution);
    _add(buffer, 'Programme', context.programme);
    _add(buffer, 'Level', context.level);
    _add(buffer, 'Semester', context.semester);
    _add(buffer, 'Course', context.course);
    _add(buffer, 'Course Outline', context.courseOutline);

    if (context.materials.isNotEmpty) {
      buffer.writeln('Course Materials:');

      for (final material in context.materials) {
        buffer.writeln('- $material');
      }

      buffer.writeln();
    }

    if (context.pastQuestions.isNotEmpty) {
      buffer.writeln('Past Questions:');

      for (final question in context.pastQuestions) {
        buffer.writeln('- $question');
      }

      buffer.writeln();
    }

    return buffer.toString().trim();
  }

  static void _add(
    StringBuffer buffer,
    String label,
    String? value,
  ) {
    if (value == null || value.trim().isEmpty) {
      return;
    }

    buffer.writeln('$label: $value');
  }
}