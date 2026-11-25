import 'package:flutter/material.dart';
import '../main.dart';
import '../models/clinic_visit.dart';
import '../services/clinic_visit_service.dart';
import '../widgets/visit_card.dart';

class NurseQueueScreen extends StatefulWidget {
  const NurseQueueScreen({super.key});

  @override
  State<NurseQueueScreen> createState() => _NurseQueueScreenState();
}

class _NurseQueueScreenState extends State<NurseQueueScreen> {
  String _selectedFilter = 'All';

  final ClinicVisitService _visitService = ClinicVisitService();

  Future<void> _markAsAttended(ClinicVisit visit) async {
    if (visit.id == null) return;

    try {
      await _visitService.markAsAttended(visit.id!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Visit marked as attended.'),
          backgroundColor: AppColors.maroon,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to update visit status. Please try again.',
          ),
          backgroundColor: AppColors.maroon,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  List<ClinicVisit> _filterVisits(List<ClinicVisit> visits) {
    if (_selectedFilter == 'Pending') {
      return visits.where((visit) => !visit.attended).toList();
    }

    if (_selectedFilter == 'Attended') {
      return visits.where((visit) => visit.attended).toList();
    }

    return visits;
  }

  String _formatTimestamp(DateTime dateTime) {
    final date = dateTime.toLocal();

    String twoDigits(int number) =>
        number.toString().padLeft(2, '0');

    return '${date.year}-${twoDigits(date.month)}-'
        '${twoDigits(date.day)}  '
        '${twoDigits(date.hour)}:${twoDigits(date.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Dashboard'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Clinic Queue',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Monitor and manage student clinic visits.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 24),

              // FIRESTORE VISIT STREAM
              Expanded(
                child: StreamBuilder<List<ClinicVisit>>(
                  stream: _visitService.getVisits(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Unable to load clinic visits.',
                          style: TextStyle(
                            color: AppColors.darkBrown,
                          ),
                        ),
                      );
                    }

                    if (snapshot.connectionState ==
                            ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.maroon,
                        ),
                      );
                    }

                    final visits = snapshot.data ?? [];

                    final pendingCount = visits
                        .where((visit) => !visit.attended)
                        .length;

                    final attendedCount = visits
                        .where((visit) => visit.attended)
                        .length;

                    final displayedVisits = _filterVisits(visits);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SUMMARY CARDS
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryCard(
                                title: 'Total Visits',
                                count: visits.length,
                                icon: Icons.people_outline,
                                color: AppColors.maroon,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: _SummaryCard(
                                title: 'Pending',
                                count: pendingCount,
                                icon: Icons.access_time,
                                color: AppColors.dustyRose,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        _SummaryCard(
                          title: 'Attended',
                          count: attendedCount,
                          icon: Icons.check_circle_outline,
                          color: AppColors.darkBrown,
                        ),

                        const SizedBox(height: 28),

                        // FILTERS
                        const Text(
                          'Visit Records',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBrown,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 8,
                          children: [
                            'All',
                            'Pending',
                            'Attended',
                          ].map((filter) {
                            final isSelected =
                                _selectedFilter == filter;

                            return ChoiceChip(
                              label: Text(filter),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = filter;
                                });
                              },
                              selectedColor: AppColors.maroon,
                              backgroundColor: AppColors.ivory,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? AppColors.ivory
                                    : AppColors.darkBrown,
                                fontWeight: FontWeight.w500,
                              ),
                              side: const BorderSide(
                                color: AppColors.mutedBeige,
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),

                        // VISIT QUEUE
                        Expanded(
                          child: displayedVisits.isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.inbox_outlined,
                                        size: 55,
                                        color: AppColors.dustyRose,
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'No clinic visits found.',
                                        style: TextStyle(
                                          color: AppColors.darkBrown,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: displayedVisits.length,
                                  separatorBuilder:
                                      (context, index) =>
                                          const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final visit =
                                        displayedVisits[index];

                                    return VisitCard(
                                      visit: visit,
                                      formattedTime:
                                          _formatTimestamp(
                                        visit.timestamp,
                                      ),
                                      onAttend: () =>
                                          _markAsAttended(visit),
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SUMMARY CARD
class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.mutedBeige,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 27,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
