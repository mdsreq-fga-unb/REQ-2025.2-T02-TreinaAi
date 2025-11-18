import 'package:flutter/material.dart';
import 'components.dart';
import '../data/clients_database.dart';
import '../models/period.dart';

class PeriodRegisterPage extends StatefulWidget {
  final int codClient;

  const PeriodRegisterPage({
    super.key,
    required this.codClient,
  });

  @override
  State<PeriodRegisterPage> createState() => _PeriodRegisterPageState();
}

class _PeriodRegisterPageState extends State<PeriodRegisterPage> {
  late TextEditingController _titleController;
  late TextEditingController _objectiveController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _objectiveController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _objectiveController.dispose();
    super.dispose();
  }

  Future<void> _savePeriod() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o título do período.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final period = Period(
        title: _titleController.text.trim(),
        objective: _objectiveController.text.trim(),
        codClient: widget.codClient,
      );

      await ClientsDatabase.instance.insertPeriod(period);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Período criado com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar período: $e'),
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

            // Logo
            Image.asset(
              'assets/logo.png',
              height: 120,
            ),

            const SizedBox(height: 24),

            // Title
            const Text(
              'Novo Período',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),

            // Fields
            TextField(
              controller: _titleController,
              decoration: formInputDecoration('Título do Período'),
              maxLength: 15,
              inputFormatters: const [],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _objectiveController,
              decoration: formInputDecoration('Objetivo (opcional)'),
              maxLines: 4,
              minLines: 2,
            ),
            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: _isSaving
                  ? const Center(
                      child: CircularProgressIndicator(color: primaryRed),
                    )
                  : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GradientButton(
                        text: 'Criar Período',
                        onPressed: _savePeriod,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
