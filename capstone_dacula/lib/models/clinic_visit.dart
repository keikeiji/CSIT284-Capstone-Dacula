class ClinicVisit {
  final String studentId;
  final String symptom;
  final DateTime timestamp;
  bool attended;

  ClinicVisit({
    required this.studentId,
    required this.symptom,
    required this.timestamp,
    this.attended = false,
  });
}