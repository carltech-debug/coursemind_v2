import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/institution_model.dart';

final class InstitutionFirestoreDataSource {
  InstitutionFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>
      get _institutions =>
          _firestore.collection('institutions');

  Future<void> createInstitution(
    InstitutionModel institution,
  ) async {
    await _institutions
        .doc(institution.id)
        .set(institution.toMap());
  }

  Future<InstitutionModel?> getInstitution(
    String institutionId,
  ) async {
    final snapshot =
        await _institutions.doc(institutionId).get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return InstitutionModel.fromMap(
      snapshot.id,
      snapshot.data()!,
    );
  }
}