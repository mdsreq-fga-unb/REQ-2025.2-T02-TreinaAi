import 'package:flutter/material.dart';
import 'ui/register_page.dart';

void main() {
  runApp(const TreinaAi());
}

class TreinaAi extends StatelessWidget {
  const TreinaAi({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TreinaAí',
      home: RegisterPage(), // vai pra register_page, adicionar aqui if(registrado) -> student_search_screen
    );
  }
}
