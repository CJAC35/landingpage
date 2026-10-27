import 'package:flutter/material.dart';
import 'screen.dart'; // Importamos la landing page

void main() {
  runApp(const SpanishTeacherApp());
}

class SpanishTeacherApp extends StatelessWidget {
  const SpanishTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal de Clases de Español',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC0392B),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDFBF7),
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 70, color: Color(0xFFC0392B)),
              const SizedBox(height: 20),
              const Text(
                'Panel Principal',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Accede a tu página de servicios y captación de alumnos.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  // Navega hacia la Landing Page que creamos en el otro archivo
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LandingPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.web),
                label: const Text('Abrir Landing Page'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}