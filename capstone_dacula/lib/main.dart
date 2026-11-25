import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'screens/student_visit_screen.dart';
import 'screens/nurse_queue_screen.dart';
import 'services/clinic_visit_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signInAnonymously();

  final visitService = ClinicVisitService();
  await visitService.addInitialVisitsIfMissing();

  runApp(const ClinicVisitApp());
}

class AppColors {
  static const Color maroon = Color(0xFF800000);
  static const Color ivory = Color(0xFFFFF8E7);
  static const Color darkBrown = Color(0xFF4E342E);
  static const Color beige = Color(0xFFF5E6CC);
  static const Color mutedBeige = Color(0xFFE8DCC8);
  static const Color dustyRose = Color(0xFFD8A7A7);
}

class ClinicVisitApp extends StatelessWidget {
  const ClinicVisitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Visit Log',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.ivory,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.maroon,
          primary: AppColors.maroon,
          secondary: AppColors.dustyRose,
          surface: AppColors.ivory,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.maroon,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clinic Visit Log',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_hospital_rounded,
                size: 85,
                color: AppColors.maroon,
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome to the Clinic Visit Log',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please select your access type to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 32),
              _buildAccessButton(
                context,
                title: 'Student',
                subtitle: 'Submit a clinic visit',
                icon: Icons.person_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentVisitScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildAccessButton(
                context,
                title: 'Nurse',
                subtitle: 'View and manage the clinic queue',
                icon: Icons.medical_services_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NurseQueueScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.beige,
                  child: Icon(
                    icon,
                    color: AppColors.maroon,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.maroon,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.maroon,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
