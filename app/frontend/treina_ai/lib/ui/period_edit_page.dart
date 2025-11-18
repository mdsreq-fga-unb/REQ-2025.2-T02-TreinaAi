import 'package:flutter/material.dart';
import 'components.dart';
import '../data/clients_database.dart';
import '../models/period.dart';

class PeriodEditPage extends StatefulWidget {
  final Period period;

  const PeriodEditPage({
    super.key,
    required this.period,
  });

  @override
  State<PeriodEditPage> createState() => _PeriodEditPageState();
}

class _PeriodEditPageState extends State<PeriodEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _objectiveController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.period.title);
    _objectiveController = TextEditingController(text: widget.period.objective ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _objectiveController.dispose();
    super.dispose();
  }

  Future<void> _updatePeriod() async {
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
      final updatedPeriod = Period(
        codPeriod: widget.period.codPeriod,
        title: _titleController.text.trim(),
        objective: _objectiveController.text.trim(),
        codClient: widget.period.codClient,
      );

      debugPrint('📝 Atualizando período: ${updatedPeriod.title}');
      await ClientsDatabase.instance.updatePeriod(updatedPeriod);
      debugPrint('✓ Período atualizado com sucesso');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Período atualizado com sucesso!'),
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
      debugPrint('❌ Erro ao atualizar período: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar período: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _showDeleteConfirmation() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Deletar Período?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Tem certeza que deseja deletar o período "${widget.period.title}"? Esta ação não pode ser desfeita.',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _deletePeriod(),
              child: const Text(
                'Deletar',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePeriod() async {
    try {
      Navigator.pop(context);

      setState(() {
        _isSaving = true;
      });

      debugPrint('🗑️  Deletando período: ${widget.period.title}');
      await ClientsDatabase.instance.deletePeriod(widget.period.codPeriod!);
      debugPrint('✓ Período deletado com sucesso');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Período deletado com sucesso!'),
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
      debugPrint('❌ Erro ao deletar período: $e');
      if (mounted) {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao deletar período: $e'),
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

            // Logo
            Image.asset(
              'assets/logo.png',
              height: 120,
            ),

            const SizedBox(height: 24),

            // Title
            const Text(
              'Editar Período',
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
                        text: 'Salvar Alterações',
                        onPressed: _updatePeriod,
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Delete Button
            SizedBox(
              width: double.infinity,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA0162B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  onPressed: _isSaving ? null : _showDeleteConfirmation,
                  child: const Text(
                    'Deletar Período',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
