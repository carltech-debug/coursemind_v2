import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/programme_model.dart';

final class ProgrammeFirestoreDataSource {
  ProgrammeFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _programmes(
    String institutionId,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes');
  }

  Future<void> createProgramme(
    ProgrammeModel programme,
  ) async {
    await _programmes(programme.institutionId)
        .doc(programme.id)
        .set(programme.toMap());
  }

  Future<List<ProgrammeModel>> getProgrammes(
    String institutionId,
  ) async {
    final snapshot = await _programmes(institutionId).get();

    return snapshot.docs
        .map(
          (doc) => ProgrammeModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}