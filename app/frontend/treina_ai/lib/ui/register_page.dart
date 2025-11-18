import 'package:flutter/material.dart';
import 'student_search_screen.dart';
import 'components.dart';
import '../data/users_database.dart';
import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers para pegar o texto dos campos
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _crefController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    // limpa os controllers
    _nameController.dispose();
    _crefController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    // verifica se o campo de nome ta preenchido
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o campo de nome.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // cria objeto User com os dados do formulário
      final user = User(
        cref: _crefController.text.trim(),
        name: _nameController.text.trim(),
        contact: _contactController.text.trim(),
      );

      // salva no banco de dados
      await DatabaseHelper.instance.insertUser(user);

      // verificação do banco de dados (remover dps) {
      final allUsers = await DatabaseHelper.instance.getUsers();
      print('VERIFICAÇÃO DO BANCO:');
      print('Total de usuários: ${allUsers.length}');
      for (var u in allUsers) {
        print('  → ${u.name} | ${u.cref} | ${u.contact}');
      }
      // } (remover dps)

      // msg de sucesso
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Leva pra student_search_screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentSearchScreen(),
          ),
        );
      }
    } catch (e) {
      print('ERRO: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
              'assets/logo.png',
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

            //===== Fields =====
            TextField(
              controller: _nameController,
              decoration: formInputDecoration('Nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _crefController,
              decoration: formInputDecoration('CREF (opcional)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contactController,
              decoration: formInputDecoration('Contato (opcional)'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 40),

            //===== Gradient Button =====
            SizedBox(
              width: double.infinity,
              child: GradientButton(
                text: 'Cadastrar',
                onPressed: _saveUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}