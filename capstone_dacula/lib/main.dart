import 'package:flutter/material.dart';

import 'screens/student_visit_screen.dart';
import 'screens/nurse_queue_screen.dart';

void main() {
  runApp(const ClinicVisitApp());
}

// APPLICATION COLORS
class AppColors {
  static const maroon = Color(0xFF702C3B);
  static const beige = Color(0xFFF5EBDD);
  static const ivory = Color(0xFFFFFDF9);
  static const dustyRose = Color(0xFFA66A76);
  static const darkBrown = Color(0xFF382820);
  static const mutedBeige = Color(0xFFE9DFD3);
}

// MAIN APPLICATION
class ClinicVisitApp extends StatelessWidget {
  const ClinicVisitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Visit Log',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.beige,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.maroon,
          primary: AppColors.maroon,
          surface: AppColors.ivory,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.beige,
          foregroundColor: AppColors.darkBrown,
          elevation: 0,
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

// HOME SCREEN
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),

              // APP BRANDING
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.maroon,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.local_hospital_outlined,
                  color: AppColors.ivory,
                  size: 35,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'CLINIC VISIT LOG',
                style: TextStyle(
                  color: AppColors.maroon,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Welcome!',
                style: TextStyle(
                  color: AppColors.darkBrown,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'A simple and organized way to manage '
                'your clinic visits.',
                style: TextStyle(
                  color: AppColors.darkBrown,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Choose your access',
                style: TextStyle(
                  color: AppColors.darkBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // STUDENT CARD
              _AccessCard(
                icon: Icons.person_outline,
                title: 'Student',
                description:
                    'Log your clinic visit and provide your symptoms.',
                buttonText: 'Continue as Student',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentVisitScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // NURSE CARD
              _AccessCard(
                icon: Icons.medical_services_outlined,
                title: 'Nurse',
                description:
                    'View the clinic queue and update visit statuses.',
                buttonText: 'Continue as Nurse',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NurseQueueScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              Center(
                child: Text(
                  'Clinic Visit Log • CSIT284',
                  style: TextStyle(
                    color: AppColors.darkBrown.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// REUSABLE ACCESS CARD
class _AccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const _AccessCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mutedBeige),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.maroon,
            size: 32,
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.darkBrown,
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.maroon,
                foregroundColor: AppColors.ivory,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

// TEMPORARY SCREENS
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({
    super.key,
    required this.title,S
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('This screen will be developed next.'),
      ),
    );
  }
}
