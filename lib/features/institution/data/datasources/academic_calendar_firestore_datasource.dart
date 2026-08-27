import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/academic_calendar_model.dart';

final class AcademicCalendarFirestoreDataSource {
  AcademicCalendarFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _calendars(
    String institutionId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('academic_calendars');
  }

  Future<void> createAcademicCalendar(
    AcademicCalendarModel calendar,
  ) async {
    await _calendars(calendar.institutionId)
        .doc(calendar.id)
        .set(calendar.toMap());
  }

  Future<List<AcademicCalendarModel>> getAcademicCalendars(
    String institutionId,
  ) async {
    final snapshot = await _calendars(institutionId).get();

    return snapshot.docs
        .map(
          (doc) => AcademicCalendarModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}