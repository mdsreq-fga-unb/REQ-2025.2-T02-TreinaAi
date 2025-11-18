import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components.dart';
import '../data/users_database.dart';
import '../models/user.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  final String codUser;

  const EditUserPage({
    super.key,
    required this.user,
    required this.codUser,
  });

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  // controllers para pegar o texto dos campos
  late TextEditingController _nameController;
  late TextEditingController _crefController;
  late TextEditingController _contactController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _crefController = TextEditingController(text: widget.user.cref);
    _contactController = TextEditingController(text: widget.user.contact);
  }

  @override
  void dispose() {
    // limpa os controllers
    _nameController.dispose();
    _crefController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
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

    setState(() {
      _isSaving = true;
    });

    try {
      // cria objeto User com os dados do formulário
      final updatedUser = User(
        cref: _crefController.text.trim(),
        name: _nameController.text.trim(),
        contact: _contactController.text.trim(),
      );

      // atualiza no banco de dados
      await DatabaseHelper.instance.updateUser(updatedUser, widget.codUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário atualizado com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Espera um pouco para a mensagem ser exibida e volta com true
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
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
              'Editar Perfil',
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
              maxLength: 20,
              inputFormatters: [
                LengthLimitingTextInputFormatter(25),
              ],
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

            //===== Save Button =====
            SizedBox(
              width: double.infinity,
              child: _isSaving
                  ? const Center(
                      child: CircularProgressIndicator(color: primaryRed),
                    )
                  : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GradientButton(
                        text: 'Salvar Alterações',
                        onPressed: _saveChanges,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
