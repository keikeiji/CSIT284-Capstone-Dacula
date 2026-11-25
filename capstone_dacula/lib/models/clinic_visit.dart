import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicVisit {
  final String? id;
  final String studentId;
  final String symptom;
  final DateTime timestamp;
  bool attended;

  ClinicVisit({
    this.id,
    required this.studentId,
    required this.symptom,
    required this.timestamp,
    this.attended = false,
  });

  // Convert a visit into data for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'symptom': symptom,
      'timestamp': Timestamp.fromDate(timestamp),
      'attended': attended,
    };
  }

  // Convert Firestore data back into a visit.
  factory ClinicVisit.fromMap(
    String documentId,
    Map<String, dynamic> data,
  ) {
    return ClinicVisit(
      id: documentId,
      studentId: data['studentId'] as String,
      symptom: data['symptom'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      attended: data['attended'] as bool? ?? false,
    );
  }
}
