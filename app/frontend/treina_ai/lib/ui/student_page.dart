import 'package:flutter/material.dart';
import 'dart:io';
import 'components.dart';
import 'edit_student_page.dart';
import 'period_register_page.dart';
import 'periodo_page.dart';
import '../models/client.dart';
import '../models/period.dart';
import '../data/clients_database.dart';

class StudentPage extends StatefulWidget {
  final String studentName;
  final String studentDescription;
  final String? studentImageUrl;
  final List<PeriodoAtivo> periodosAtivos;
  final List<PeriodoFechado> periodosFechados;
  final VoidCallback onEditProfile;
  final VoidCallback onAddPeriodo;
  final Function(PeriodoAtivo) onTapPeriodoAtivo;
  final Function(PeriodoFechado) onTapPeriodoFechado;
  final Client client;

  const StudentPage({
    super.key,
    required this.studentName,
    required this.studentDescription,
    this.studentImageUrl,
    required this.periodosAtivos,
    required this.periodosFechados,
    required this.onEditProfile,
    required this.onAddPeriodo,
    required this.onTapPeriodoAtivo,
    required this.onTapPeriodoFechado,
    required this.client,
  });

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Client currentClient;
  late List<Period> periods = [];

  @override
  void initState() {
    super.initState();
    currentClient = widget.client;
    _loadPeriods();
  }

  Future<void> _loadPeriods() async {
    try {
      final loadedPeriods = await ClientsDatabase.instance
          .getPeriodsByClient(widget.client.codClient!);
      setState(() {
        periods = loadedPeriods;
      });
    } catch (e) {
      debugPrint('Erro ao carregar períodos: $e');
    }
  }

  List<Period> get openPeriods => periods.where((p) => !p.isClosed).toList();
  List<Period> get closedPeriods => periods.where((p) => p.isClosed).toList();

  void _navigateToEditStudent() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStudentPage(
          client: currentClient,
          onSaveSuccess: () {
            // Callback executado quando salva
          },
        ),
      ),
    );

    // Após retornar, recarregar dados do aluno
    if (result == true) {
      _reloadStudentData();
    }
  }

  void _navigateToRegisterPeriod() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeriodRegisterPage(
          codClient: widget.client.codClient!,
        ),
      ),
    );

    // Após retornar, recarregar períodos
    if (result == true) {
      _loadPeriods();
    }
  }

  void _navigateToPeriodPage(Period period) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeriodoPage(
          period: period,
        ),
      ),
    );

    // Se houve alterações (edição ou deleção), recarrega os períodos
    if (result == true) {
      _loadPeriods();
    }
  }

  Future<void> _reloadStudentData() async {
    try {
      final updatedClient = await ClientsDatabase.instance
          .getClientById(widget.client.codClient!);

      if (updatedClient != null) {
        setState(() {
          currentClient = updatedClient;
        });
        // Retornar true para a StudentSearchScreen saber que houve atualização
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context, true);
        });
      }
    } catch (e) {
      debugPrint('Erro ao recarregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==================== HEADER COM BACK BUTTON ====================
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
            ),

            // ==================== PERFIL DO ESTUDANTE ====================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Foto do Estudante
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      image: currentClient.photoPath != null
                          ? DecorationImage(
                              image: FileImage(
                                  File(currentClient.photoPath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: currentClient.photoPath == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  // Nome do Estudante
                  Text(
                    currentClient.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // ==================== DESCRIÇÃO ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentClient.desc ?? 'Sem descrição',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),

            // ==================== PERÍODOS ATIVOS ====================
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Períodos Ativos:',
                  style: titleText,
                ),
              ),
            ),

            // Períodos Ativos com Wrap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  ...openPeriods.map((period) {
                    return SquareActionButton(
                      text: "${period.title}\n${period.objective ?? "Sem objetivo"}",
                      color: primaryRed,
                      onPressed: () => _navigateToPeriodPage(period),
                    );
                  }).toList(),
                  AddSquareButton(onPressed: _navigateToRegisterPeriod),
                ],
              ),
            ),

            // ==================== PERÍODOS FECHADOS ====================
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Períodos Fechados:',
                  style: titleText,
                ),
              ),
            ),

            // Grid de Períodos Fechados
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: closedPeriods.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Nenhum período fechado',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: closedPeriods.map((period) {
                        return SquareActionButton(
                          text: "${period.title}\n${period.objective ?? "Sem objetivo"}",
                          color: const Color(0xFF6B2C2C),
                          onPressed: () => _navigateToPeriodPage(period),
                        );
                      }).toList(),
                    ),
            ),

            // ==================== BOTÃO EDITAR PERFIL ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: DarkRoundedButton(
                  text: 'Editar Perfil',
                  onPressed: _navigateToEditStudent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PERÍODO CARD (ATIVO) ====================
class PeriodoCard extends StatelessWidget {
  final String mes;
  final String objetivo;
  final String descricao;
  final Color color;

  const PeriodoCard({
    super.key,
    required this.mes,
    required this.objetivo,
    required this.descricao,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mes,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Objetivo:\n$objetivo',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ==================== PERÍODO CARD FECHADO ====================
class PeriodoCardFechado extends StatelessWidget {
  final String mes;
  final String objetivo;
  final String descricao;
  final Color color;

  const PeriodoCardFechado({
    super.key,
    required this.mes,
    required this.objetivo,
    required this.descricao,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mes,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Objetivo:\n$objetivo',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ==================== MODELOS DE DADOS ====================
class PeriodoAtivo {
  final String mes;
  final String objetivo;
  final String descricao;
  final Color color;

  PeriodoAtivo({
    required this.mes,
    required this.objetivo,
    required this.descricao,
    required this.color,
  });
}

class PeriodoFechado {
  final String mes;
  final String objetivo;
  final String descricao;
  final Color color;

  PeriodoFechado({
    required this.mes,
    required this.objetivo,
    required this.descricao,
    required this.color,
  });
}
