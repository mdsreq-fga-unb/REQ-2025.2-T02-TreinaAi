import 'package:flutter/material.dart';
import 'components.dart';

class TrainingPage extends StatefulWidget {
  final String date;

  const TrainingPage({super.key, required this.date});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  List<String> exercises = [
    "Abdominal",
    "Polichinelo",
    "Levantamento de peso",
  ];

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
            for (var exercise in exercises) ...[
              _exerciseTile(exercise),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  //==================== WIDGET DO EXERCÍCIO ====================
  Widget _exerciseTile(String title) {
    return GradientButton(
      text: title,
      width: double.infinity,
      onPressed: () {},
    );
  }
}
