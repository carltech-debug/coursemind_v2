class AcademicContext {
  const AcademicContext({
    this.institution,
    this.programme,
    this.level,
    this.semester,
    this.course,
    this.courseOutline,
    this.materials = const [],
    this.pastQuestions = const [],
  });

  final String? institution;
  final String? programme;
  final String? level;
  final String? semester;
  final String? course;
  final String? courseOutline;
  final List<String> materials;
  final List<String> pastQuestions;

  Map<String, dynamic> toMap() {
    return {
      'institution': institution,
      'programme': programme,
      'level': level,
      'semester': semester,
      'course': course,
      'courseOutline': courseOutline,
      'materials': materials,
      'pastQuestions': pastQuestions,
    };
  }
}