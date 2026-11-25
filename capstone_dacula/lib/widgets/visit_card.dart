import 'package:flutter/material.dart';
import '../main.dart';
import '../models/clinic_visit.dart';

// INDIVIDUAL VISIT CARD
class VisitCard extends StatelessWidget {
  final ClinicVisit visit;
  final String formattedTime;
  final VoidCallback onAttend;

  const VisitCard({
    super.key,
    required this.visit,
    required this.formattedTime,
    required this.onAttend,
  });

  @override
  Widget build(BuildContext context) {
    final attended = visit.attended;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.mutedBeige,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  visit.studentId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.darkBrown,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: attended
                      ? const Color(0xFFE6EFE5)
                      : const Color(0xFFF5E1E3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  attended ? 'Attended' : 'Pending',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: attended
                        ? const Color(0xFF426344)
                        : AppColors.maroon,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          Text(
            visit.symptom,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkBrown,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 15,
                color: AppColors.dustyRose,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.darkBrown,
                  ),
                ),
              ),
            ],
          ),

          if (!attended) ...[
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onAttend,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.maroon,
                  foregroundColor: AppColors.ivory,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Mark as Attended'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}