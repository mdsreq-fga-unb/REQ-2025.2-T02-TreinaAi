import 'package:flutter/material.dart';
import 'components.dart'; // importa estilos e componentes

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedGender;

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
            // LOGO
            Image.asset(
              'assets/logo.png',
              height: 140,
            ),
            const SizedBox(height: 24),

            // TÍTULO
            const Text('Cadastre-se!', style: titleText),
            const SizedBox(height: 24),

            // CAMPOS
            TextField(decoration: defaultInputDecoration('Nome completo')),
            const SizedBox(height: 16),
            TextField(decoration: defaultInputDecoration('Email')),
            const SizedBox(height: 24),

            // GÊNERO
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Gênero', style: sectionTitle),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              children: [
                GenderButton(
                  gender: 'Feminino',
                  selected: _selectedGender == 'Feminino',
                  onTap: () => setState(() => _selectedGender = 'Feminino'),
                ),
                GenderButton(
                  gender: 'Masculino',
                  selected: _selectedGender == 'Masculino',
                  onTap: () => setState(() => _selectedGender = 'Masculino'),
                ),
                GenderButton(
                  gender: 'Outro',
                  selected: _selectedGender == 'Outro',
                  onTap: () => setState(() => _selectedGender = 'Outro'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // BOTÃO CADASTRAR
            GradientButton(
              text: 'Cadastrar',
              onPressed: () {
                // ação de cadastro
              },
            ),
          ],
        ),
      ),
    );
  }
}
