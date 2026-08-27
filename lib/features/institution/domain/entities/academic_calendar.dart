class AcademicCalendar {
  const AcademicCalendar({
    required this.id,
    required this.institutionId,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
  });

  final String id;
  final String institutionId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
}