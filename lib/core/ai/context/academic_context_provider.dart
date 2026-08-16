import 'academic_context.dart';

abstract interface class AcademicContextProvider {
  Future<AcademicContext> getContext({
    required String studentId,
    required String courseId,
  });
}