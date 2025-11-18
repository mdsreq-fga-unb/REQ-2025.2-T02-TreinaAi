import 'package:flutter/material.dart';
import 'components.dart';

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final double weight;
  bool isExpanded;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    this.isExpanded = false,
  });
}

class TrainingPage extends StatefulWidget {
  final String date;

  const TrainingPage({super.key, required this.date});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  late List<Exercise> exercises;

  @override
  void initState() {
    super.initState();
    exercises = [
      Exercise(name: "Abdominal", sets: 3, reps: 15, weight: 0),
      Exercise(name: "Polichinelo", sets: 4, reps: 20, weight: 0),
      Exercise(name: "Levantamento de peso", sets: 3, reps: 8, weight: 20),
    ];
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO PRINCIPAL
            Text(
              "Treino ${widget.date}",
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

            // BOTÃO DE ADICIONAR (+)
            AddExerciseButton(
              onPressed: () {
                // ação do botão
              },
            ),

            const SizedBox(height: 25),

            // LISTA DE EXERCÍCIOS
            for (var i = 0; i < exercises.length; i++) ...[
              _exerciseTile(exercises[i], i),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //============== WIDGET DO EXERCÍCIO EXPANSÍVEL ====
  Widget _exerciseTile(Exercise exercise, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          exercise.isExpanded = !exercise.isExpanded;
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
                      exercise.isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
              // CONTEÚDO EXPANSÍVEL
              if (exercise.isExpanded)
                Container(
                  color: Colors.white.withOpacity(0.15),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow("Séries", "${exercise.sets}"),
                      const SizedBox(height: 12),
                      _infoRow("Repetições", "${exercise.reps}"),
                      const SizedBox(height: 12),
                      _infoRow(
                        "Peso",
                        exercise.weight > 0 ? "${exercise.weight} kg" : "Sem peso",
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
