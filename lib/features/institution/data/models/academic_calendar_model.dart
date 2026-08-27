import '../../domain/entities/academic_calendar.dart';

class AcademicCalendarModel extends AcademicCalendar {
  const AcademicCalendarModel({
    required super.id,
    required super.institutionId,
    required super.name,
    required super.startDate,
    required super.endDate,
    super.isActive,
  });

  factory AcademicCalendarModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return AcademicCalendarModel(
      id: id,
      institutionId: map['institutionId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      startDate: DateTime.parse(
        map['startDate'] as String,
      ),
      endDate: DateTime.parse(
        map['endDate'] as String,
      ),
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institutionId': institutionId,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}