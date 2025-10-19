import 'package:flutter/material.dart';
import 'student_search_screen.dart';
import 'components.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            Text(
              'Cadastre-se!',
              style: titleText.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 24),

            TextField(decoration: defaultInputDecoration('Nome completo')),
            const SizedBox(height: 16),
            TextField(decoration: defaultInputDecoration('CREF')),
            const SizedBox(height: 16),
            TextField(decoration: defaultInputDecoration('Contato')),
            const SizedBox(height: 40),

            GradientButton(
              text: 'Cadastrar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentSearchScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}