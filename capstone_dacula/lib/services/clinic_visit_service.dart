import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/clinic_visit.dart';
import '../models/clinic_visit_data.dart';

class ClinicVisitService {
  final CollectionReference<Map<String, dynamic>> _visitsCollection =
      FirebaseFirestore.instance.collection('clinic_visits');

  // Add a new clinic visit.
  Future<void> addVisit(ClinicVisit visit) async {
    await _visitsCollection.add(visit.toMap());
  }

  // Get clinic visits in real time.
  Stream<List<ClinicVisit>> getVisits() {
    return _visitsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return ClinicVisit.fromMap(
          document.id,
          document.data(),
        );
      }).toList();
    });
  }

  // Update a visit's attendance status.
  Future<void> markAsAttended(String documentId) async {
    await _visitsCollection.doc(documentId).update({
      'attended': true,
    });
  }

  // Add the 10 original sample visits without creating duplicates.
  Future<void> addInitialVisitsIfMissing() async {
    for (final visit in ClinicVisitData.visits) {
      final documentId = 'sample_${visit.studentId}';
      final document = _visitsCollection.doc(documentId);

      final existingVisit = await document.get();

      if (!existingVisit.exists) {
        await document.set(visit.toMap());
      }
    }
  }
}
