import 'package:flutter/material.dart';
import '../main.dart';

class StudentVisitScreen extends StatefulWidget {
  const StudentVisitScreen({super.key});

  @override
  State<StudentVisitScreen> createState() =>
      _StudentVisitScreenState();
}

class _StudentVisitScreenState extends State<StudentVisitScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _studentIdController =
      TextEditingController();

  final TextEditingController _symptomController =
      TextEditingController();

  DateTime? _submittedTime;

  @override
  void dispose() {
    _studentIdController.dispose();
    _symptomController.dispose();
    super.dispose();
  }

  void _submitVisit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _submittedTime = DateTime.now();
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.ivory,
        icon: const Icon(
          Icons.check_circle_outline,
          color: AppColors.maroon,
          size: 45,
        ),
        title: const Text(
          'Visit Submitted!',
          style: TextStyle(color: AppColors.darkBrown),
        ),
        content: const Text(
          'Your clinic visit has been recorded successfully.',
          style: TextStyle(color: AppColors.darkBrown),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _formKey.currentState!.reset();
              _studentIdController.clear();
              _symptomController.clear();

              setState(() {
                _submittedTime = null;
              });
            },
            child: const Text(
              'Done',
              style: TextStyle(color: AppColors.maroon),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Visit Form'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.local_hospital_outlined,
                  color: AppColors.maroon,
                  size: 38,
                ),

                const SizedBox(height: 18),

                const Text(
                  'Log Your Clinic Visit',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Please provide the necessary information '
                  'about your clinic visit.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Student ID',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: _studentIdController,
                  decoration: _inputDecoration(
                    hint: 'Enter your student ID',
                    icon: Icons.badge_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your student ID.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                const Text(
                  'Symptom / Reason for Visit',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: _symptomController,
                  maxLines: 4,
                  decoration: _inputDecoration(
                    hint: 'Describe your symptom or reason...',
                    icon: Icons.edit_note,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please describe your reason for visiting.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // AUTOMATIC TIMESTAMP
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.mutedBeige,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.maroon,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Visit Date & Time',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkBrown,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _submittedTime == null
                                  ? 'Automatically recorded upon submission'
                                  : _submittedTime!.toLocal().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.darkBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _submitVisit,
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Submit Visit'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.maroon,
                      foregroundColor: AppColors.ivory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'Please make sure your information is correct.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: AppColors.dustyRose,
      ),
      filled: true,
      fillColor: AppColors.ivory,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.mutedBeige,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.mutedBeige,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.maroon,
          width: 1.5,
        ),
      ),
    );
  }
}
