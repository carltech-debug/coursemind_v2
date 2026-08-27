import '../entities/academic_calendar.dart';
import '../repositories/academic_calendar_repository.dart';

final class CreateAcademicCalendar {
  const CreateAcademicCalendar(this._repository);

  final AcademicCalendarRepository _repository;

  Future<void> call(AcademicCalendar calendar) {
    return _repository.createAcademicCalendar(calendar);
  }
}