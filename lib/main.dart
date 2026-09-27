import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';

void main() => runApp(const StudyFlowApp());

class StudyFlowApp extends StatelessWidget {
  const StudyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.fromSeed(
      seedColor: const Color(0xFF163B70),
      primary: const Color(0xFF163B70),
      secondary: const Color(0xFF427DAD),
      primaryContainer: const Color(0xFFDCEEFF),
      surface: Colors.white,
    );
    return MaterialApp(
      title: 'StudyFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colors,
        scaffoldBackgroundColor: const Color(0xFFF3F8FE),
        appBarTheme: const AppBarTheme(centerTitle: false),
        cardTheme: const CardThemeData(color: Colors.white, elevation: 0),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFDCEEFF),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size(48, 52)),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}
