import '../entities/academic_calendar.dart';

abstract interface class AcademicCalendarRepository {
  Future<void> createAcademicCalendar(
    AcademicCalendar calendar,
  );

  Future<List<AcademicCalendar>> getAcademicCalendars(
    String institutionId,
  );
}