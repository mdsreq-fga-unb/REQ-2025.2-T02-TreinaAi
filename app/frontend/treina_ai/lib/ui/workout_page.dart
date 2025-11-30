import 'package:flutter/material.dart';
import 'components.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../data/clients_database.dart';
import 'workout_edit_page.dart';

class TrainingPage extends StatefulWidget {
  final Workout workout;

  const TrainingPage({super.key, required this.workout});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  late List<Exercise> exercises = [];
  bool _isLoading = true;
  final Map<int, bool> _expandedState = {};

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    try {
      final loadedExercises = await ClientsDatabase.instance
          .getExercisesByWorkout(widget.workout.codWorkout!);
      setState(() {
        exercises = loadedExercises;
        // Inicializar estado de expansão
        for (int i = 0; i < exercises.length; i++) {
          _expandedState[i] = false;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutEditPage(workout: widget.workout),
                ),
              );
              if (result == true && mounted) {
                _loadExercises();
                // Retornar true para PeriodoPage recarregar treinos
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFE67C5B)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TÍTULO PRINCIPAL
                  Text(
                    "Treino ${widget.workout.date}",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // SUBTÍTULO
                  const Text(
                    "Exercícios",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // LISTA DE EXERCÍCIOS
                  exercises.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'Nenhum exercício registrado',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            for (var i = 0; i < exercises.length; i++) ...[
                              _exerciseTile(exercises[i], i),
                              const SizedBox(height: 12),
                            ],
                          ],
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  //============== WIDGET DO EXERCÍCIO EXPANSÍVEL ====
  Widget _exerciseTile(Exercise exercise, int index) {
    final isExpanded = _expandedState[index] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedState[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              // HEADER DO EXERCÍCIO
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
              // CONTEÚDO EXPANSÍVEL
              if (isExpanded)
                Container(
                  color: Colors.white.withOpacity(0.15),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow("Séries", "${exercise.sets ?? '-'}"),
                      const SizedBox(height: 12),
                      _infoRow("Repetições", "${exercise.reps ?? '-'}"),
                      const SizedBox(height: 12),
                      _infoRow(
                        "Peso",
                        exercise.weight != null && exercise.weight! > 0 ? "${exercise.weight} kg" : "Sem peso",
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        "Isometria",
                        exercise.isometrytime != null && exercise.isometrytime! > 0 ? "${exercise.isometrytime}s" : "Sem isometria",
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  //======== WIDGET DE INFORMAÇÃO ======
  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
