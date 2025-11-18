import 'package:flutter/material.dart';
import 'components.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../data/clients_database.dart';
import 'period_edit_page.dart';

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
    try {
      final now = DateTime.now();
      final dateString = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
      
      final workout = Workout(
        date: dateString,
        notes: 'Treino $dateString',
        codPeriod: widget.period.codPeriod!,
      );

      await ClientsDatabase.instance.insertWorkout(workout);
      await _loadWorkouts();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Treino adicionado!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erro ao adicionar treino: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao adicionar treino: $e'),
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
                debugPrint('✓ Período atualizado/deletado, retornando ao StudentPage');
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

                //Botão adicionar treino
                GestureDetector(
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
                    backgroundColor: const Color(0xFFA0162B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Fechar Período",
                    style: TextStyle(
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
