import 'package:flutter/material.dart';
import 'components.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../data/clients_database.dart';
import 'period_edit_page.dart';
import 'workout_register_page.dart';
import 'workout_page.dart';
import 'training_chart_page.dart';

class PeriodoPage extends StatefulWidget {
  final Period period;

  const PeriodoPage({
    super.key,
    required this.period,
  });

  @override
  State<PeriodoPage> createState() => _PeriodoPageState();
}

class _PeriodoPageState extends State<PeriodoPage> {
  late List<Workout> workouts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    try {
      final loadedWorkouts = await ClientsDatabase.instance
          .getWorkoutsByPeriod(widget.period.codPeriod!);
      setState(() {
        workouts = loadedWorkouts;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar treinos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addWorkout() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutRegisterPage(
          codPeriod: widget.period.codPeriod!,
        ),
      ),
    );

    // Se houve adição de treino, recarrega os treinos
    if (result == true) {
      _loadWorkouts();
    }
  }

  Future<void> _navigateToWorkout(Workout workout) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingPage(workout: workout),
      ),
    );

    // Se houve atualização/deleção de treino, recarrega a lista
    if (result == true) {
      _loadWorkouts();
    }
  }

  Future<void> _showClosePeriodConfirmation() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Fechar Período?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Tem certeza que deseja fechar o período "${widget.period.title}"? Períodos fechados não podem ser editados nem receber novos treinos.',
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
              onPressed: () => _closePeriod(),
              child: const Text(
                'Fechar',
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

  Future<void> _closePeriod() async {
    try {
      Navigator.pop(context);

      final closedPeriod = Period(
        codPeriod: widget.period.codPeriod,
        title: widget.period.title,
        objective: widget.period.objective,
        observations: widget.period.observations,
        isClosed: true,
        codClient: widget.period.codClient,
      );

      await ClientsDatabase.instance.updatePeriod(closedPeriod);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Período fechado com sucesso!'),
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
      debugPrint('Erro ao fechar período: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao fechar período: $e'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.period.title.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          if (!widget.period.isClosed)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PeriodEditPage(period: widget.period),
                  ),
                );
                if (result == true && mounted) {
                  Navigator.pop(context, true);
                }
              },
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Objetivo: ${widget.period.objective ?? 'Sem objetivo definido'}",
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (widget.period.observations != null && widget.period.observations!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Observações:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.period.observations!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 30),

                // Training Plan
                const Text(
                  "Plano de Treino",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 12),

                // Side by side buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareActionButton(
                      text: "Baixar\nplanilha",
                      color: const Color(0xFF0C1F28),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 24),
                    AddSquareButton(
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                const Text(
                  "Treinos realizados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C1F28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingChartPage(period: widget.period),
                        ),
                      );
                    },
                    child: const Text(
                      "Ver Análises e Gráficos",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),


                //Botão adicionar treino
                if (!widget.period.isClosed)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _addWorkout,
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE67C5B)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: Color(0xFFE67C5B)),
                        ),
                      ),
                    ),
                  ),
                if (!widget.period.isClosed)
                const SizedBox(height: 14),

                //Lista de treinos
                _isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(
                            color: Color(0xFFE67C5B),
                          ),
                        ),
                      )
                    : workouts.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                'Nenhum treino registrado',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              for (var workout in workouts)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () => _navigateToWorkout(workout),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE67C5B),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Treino ${workout.date}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                const SizedBox(height: 24),

              //Botões Gerar PDF e Fechar Período
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C1F28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Gerar PDF",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.period.isClosed ? Colors.grey : const Color(0xFFA0162B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  onPressed: widget.period.isClosed ? null : _showClosePeriodConfirmation,
                  child: Text(
                    widget.period.isClosed ? "Período Fechado" : "Fechar Período",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
