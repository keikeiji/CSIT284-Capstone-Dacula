import 'clinic_visit.dart';

class ClinicVisitData {
  static final List<ClinicVisit> visits = [
    ClinicVisit(
      studentId: '2024-00125',
      symptom: 'Headache',
      timestamp: DateTime.now().subtract(
        const Duration(minutes: 15),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00138',
      symptom: 'Stomachache',
      timestamp: DateTime.now().subtract(
        const Duration(minutes: 30),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00142',
      symptom: 'Dizziness',
      timestamp: DateTime.now().subtract(
        const Duration(minutes: 45),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00156',
      symptom: 'General consultation',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 1),
      ),
      attended: true,
    ),
    ClinicVisit(
      studentId: '2024-00167',
      symptom: 'Cough and colds',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 2),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00172',
      symptom: 'Stomach pain',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 3),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00184',
      symptom: 'Minor headache',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 4),
      ),
      attended: true,
    ),
    ClinicVisit(
      studentId: '2024-00193',
      symptom: 'Dizziness',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 5),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00201',
      symptom: 'General consultation',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 6),
      ),
    ),
    ClinicVisit(
      studentId: '2024-00215',
      symptom: 'Stomachache',
      timestamp: DateTime.now().subtract(
        const Duration(hours: 7),
      ),
    ),
  ];
}
