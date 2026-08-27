import '../entities/academic_calendar.dart';
import '../repositories/academic_calendar_repository.dart';

final class GetAcademicCalendars {
  const GetAcademicCalendars(this._repository);

  final AcademicCalendarRepository _repository;

  Future<List<AcademicCalendar>> call(
    String institutionId,
  ) {
    return _repository.getAcademicCalendars(
      institutionId,
    );
  }
}