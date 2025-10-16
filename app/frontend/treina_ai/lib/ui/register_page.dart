import 'package:flutter/material.dart';
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
            //LOGO
            // Image.asset(
            //   'assets/logo.png',
            //   height: 140,
            // ),
            const SizedBox(height: 24),

            //title 'Cadastre-se!'
            Text('Cadastre-se!', 
              style: titleText.copyWith(color: Colors.black)
            ),
            const SizedBox(height: 24),

            //Form Fields
            TextField(decoration: defaultInputDecoration('Nome completo')),
            const SizedBox(height: 16),
            TextField(decoration: defaultInputDecoration('CREF')),
            const SizedBox(height: 16),
            TextField(decoration: defaultInputDecoration('Contato')),
            const SizedBox(height: 40),

            //Register Button
            GradientButton(
              text: 'Cadastrar',
              onPressed: () {
                //Cadastro action
              },
            ),
          ],
        ),
      ),
    );
  }
} 