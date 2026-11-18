import 'package:flutter/material.dart';
import '../main.dart';
import '../models/clinic_visit.dart';
import '../models/clinic_visit_data.dart';
import '../widgets/visit_card.dart';

class NurseQueueScreen extends StatefulWidget {
  const NurseQueueScreen({super.key});

  @override
  State<NurseQueueScreen> createState() => _NurseQueueScreenState();
}

class _NurseQueueScreenState extends State<NurseQueueScreen> {
  String _selectedFilter = 'All';

  List<ClinicVisit> get _visits => ClinicVisitData.visits;

  int get _pendingCount =>
      _visits.where((visit) => !visit.attended).length;

  int get _attendedCount =>
      _visits.where((visit) => visit.attended).length;

  List<ClinicVisit> get _filteredVisits {
    if (_selectedFilter == 'Pending') {
      return _visits.where((visit) => !visit.attended).toList();
    }

    if (_selectedFilter == 'Attended') {
      return _visits.where((visit) => visit.attended).toList();
    }

    return _visits;
  }

  void _markAsAttended(ClinicVisit visit) {
    setState(() {
      visit.attended = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Visit marked as attended.'),
        backgroundColor: AppColors.maroon,
        behavior: SnackBarBehavior.floating,
      ),
    );
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
    final displayedVisits = _filteredVisits;

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

              // SUMMARY CARDS
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Total Visits',
                      count: _visits.length,
                      icon: Icons.people_outline,
                      color: AppColors.maroon,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _SummaryCard(
                      title: 'Pending',
                      count: _pendingCount,
                      icon: Icons.access_time,
                      color: AppColors.dustyRose,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _SummaryCard(
                title: 'Attended',
                count: _attendedCount,
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
                children: ['All', 'Pending', 'Attended'].map(
                  (filter) {
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
                  },
                ).toList(),
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
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final visit = displayedVisits[index];

                          return VisitCard(
                            visit: visit,
                            formattedTime:
                                _formatTimestamp(visit.timestamp),
                            onAttend: () =>
                                _markAsAttended(visit),
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
