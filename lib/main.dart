import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MindLogApp());
}

class MindLogApp extends StatelessWidget {
  const MindLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B6B),
        // backgroundColor: const Color(0xFFFFFBF2),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF6A5ACD),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}