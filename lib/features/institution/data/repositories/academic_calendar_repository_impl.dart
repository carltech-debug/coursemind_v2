import '../../domain/entities/academic_calendar.dart';
import '../../domain/repositories/academic_calendar_repository.dart';
import '../datasources/academic_calendar_firestore_datasource.dart';
import '../models/academic_calendar_model.dart';

final class AcademicCalendarRepositoryImpl
    implements AcademicCalendarRepository {
  AcademicCalendarRepositoryImpl({
    required this._dataSource,
  });

  final AcademicCalendarFirestoreDataSource _dataSource;

  @override
  Future<void> createAcademicCalendar(
    AcademicCalendar calendar,
  ) {
    return _dataSource.createAcademicCalendar(
      AcademicCalendarModel(
        id: calendar.id,
        institutionId: calendar.institutionId,
        name: calendar.name,
        startDate: calendar.startDate,
        endDate: calendar.endDate,
        isActive: calendar.isActive,
      ),
    );
  }

  @override
  Future<List<AcademicCalendar>> getAcademicCalendars(
    String institutionId,
  ) {
    return _dataSource.getAcademicCalendars(
      institutionId,
    );
  }
}