import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/fake_whatsapp_screen.dart';
import 'screens/lock_screen.dart';

void main() {
  runApp(const ParentalControlApp());
}

class ParentalControlApp extends StatelessWidget {
  const ParentalControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeGuard: Channel Blocker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // WhatsApp-like Green / Security Green
          secondary: const Color(0xFF128C7E),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SetupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/simulation': (context) => const FakeWhatsAppScreen(),
        '/lock': (context) => const LockScreen(),
      },
    );
  }
}
