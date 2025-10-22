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
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // ===== LOGO =====
            Image.asset(
              'assets/logo.png', // coloque aqui o caminho da sua imagem
              height: 120,
            ),

            const SizedBox(height: 24),

            //===== Tittle =====
            const Text(
              'Cadastre-se!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),

            //=====Filds =====
            TextField(decoration: formInputDecoration('Nome completo')),
            const SizedBox(height: 16),
            TextField(decoration: formInputDecoration('CREF')),
            const SizedBox(height: 16),
            TextField(decoration: formInputDecoration('Contato')),
            const SizedBox(height: 40),

            //===== Gradient Button =====
           SizedBox(
              width: double.infinity,
              child: GradientButton(
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
),

          ],
        ),
      ),
    );
  }
}