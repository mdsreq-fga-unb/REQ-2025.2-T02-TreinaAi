import 'package:flutter/material.dart';
import 'ui/student_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreinaAi',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: StudentSearchScreen(), // REMOVEU O CONST
      debugShowCheckedModeBanner: false,
    );
  }
}