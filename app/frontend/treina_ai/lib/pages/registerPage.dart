import 'package:flutter/material.dart';

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
          onPressed: () {},
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //LOGO
            Image.asset(
              'assets/logo.png', 
              height: 140,
            ),
            const SizedBox(height: 24),

            //TÍTLE
            const Text(
              'Cadastre-se!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            //FIELD NAME
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome completo',
                border: const UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 16),

            //FIELD EMAIL
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: const UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 24),

            //GENRE
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gênero',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              children: [
                _genderButton('Feminino'),
                _genderButton('Masculino'),
                _genderButton('Outro'),
              ],
            ),

            const SizedBox(height: 40),

            //REGISTER BUTTON
            GestureDetector(
              onTap: () {
                
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A5C), Color(0xFFC30000)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderButton(String gender) {
    final isSelected = _selectedGender == gender;

    return ChoiceChip(
      label: Text(gender),
      selected: isSelected,
      selectedColor: const Color(0xFFE53935).withOpacity(0.1),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFFE53935) : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: Color(0xFFE53935)),
      onSelected: (selected) {
        setState(() {
          _selectedGender = gender;
        });
      },
    );
  }
}
