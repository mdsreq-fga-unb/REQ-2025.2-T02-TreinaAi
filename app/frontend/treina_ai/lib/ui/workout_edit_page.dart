import 'package:flutter/material.dart';
import 'components.dart';
import '../data/clients_database.dart';
import '../models/workout.dart';
import '../models/exercise.dart';

class ExerciseEditInput {
  final int? codExercise;
  String name;
  int? sets;
  int? reps;
  double? weight;
  int? isometrytime;

  ExerciseEditInput({
    this.codExercise,
    required this.name,
    this.sets,
    this.reps,
    this.weight,
    this.isometrytime,
  });
}

class WorkoutEditPage extends StatefulWidget {
  final Workout workout;

  const WorkoutEditPage({
    super.key,
    required this.workout,
  });

  @override
  State<WorkoutEditPage> createState() => _WorkoutEditPageState();
}

class _WorkoutEditPageState extends State<WorkoutEditPage> {
  late TextEditingController _dateController;
  late List<ExerciseEditInput> exercises = [];
  bool _isSaving = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.workout.date);
    _loadExercises();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    try {
      final loadedExercises = await ClientsDatabase.instance
          .getExercisesByWorkout(widget.workout.codWorkout!);
      setState(() {
        exercises = loadedExercises
            .map((e) => ExerciseEditInput(
                  codExercise: e.codExercise,
                  name: e.name,
                  sets: e.sets,
                  reps: e.reps,
                  weight: e.weight,
                  isometrytime: e.isometrytime,
                ))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formattedDate =
          '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
      _dateController.text = formattedDate;
    }
  }

  void _addExercise() {
    setState(() {
      exercises.add(ExerciseEditInput(name: ''));
    });
  }

  void _removeExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  Future<void> _saveWorkout() async {
    if (_dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha a data do treino.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, adicione pelo menos um exercício.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validar se todos os exercícios têm nome
    for (var exercise in exercises) {
      if (exercise.name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, preencha o nome de todos os exercícios.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Atualizar treino
      final updatedWorkout = Workout(
        codWorkout: widget.workout.codWorkout,
        date: _dateController.text,
        notes: widget.workout.notes,
        codPeriod: widget.workout.codPeriod,
      );

      await ClientsDatabase.instance.updateWorkout(updatedWorkout);

      // Deletar exercícios antigos e inserir novos
      final oldExercises = await ClientsDatabase.instance
          .getExercisesByWorkout(widget.workout.codWorkout!);
      
      for (var oldExercise in oldExercises) {
        await ClientsDatabase.instance.deleteExercise(oldExercise.codExercise!);
      }

      // Inserir novos exercícios
      for (var exerciseInput in exercises) {
        final exercise = Exercise(
          name: exerciseInput.name,
          sets: exerciseInput.sets,
          reps: exerciseInput.reps,
          weight: exerciseInput.weight,
          isometrytime: exerciseInput.isometrytime,
          codWorkout: widget.workout.codWorkout!,
        );
        await ClientsDatabase.instance.insertExercise(exercise);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Treino atualizado com sucesso!'),
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
            content: Text('Erro ao atualizar treino: $e'),
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
            'Deletar Treino?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Tem certeza que deseja deletar o treino de ${widget.workout.date}? Esta ação não pode ser desfeita.',
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
              onPressed: () => _deleteWorkout(),
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

  Future<void> _deleteWorkout() async {
    try {
      Navigator.pop(context);

      setState(() {
        _isSaving = true;
      });

      // Deletar exercícios
      final oldExercises = await ClientsDatabase.instance
          .getExercisesByWorkout(widget.workout.codWorkout!);
      
      for (var exercise in oldExercises) {
        await ClientsDatabase.instance.deleteExercise(exercise.codExercise!);
      }

      // Deletar treino
      await ClientsDatabase.instance.deleteWorkout(widget.workout.codWorkout!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Treino deletado com sucesso!'),
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
      debugPrint('Erro ao deletar treino: $e');
      if (mounted) {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao deletar treino: $e'),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFE67C5B)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // Logo
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Editar Treino',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Date Field
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: formInputDecoration('Data do Treino'),
                    onTap: _selectDate,
                  ),
                  const SizedBox(height: 24),

                  // Exercises Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Exercícios',
                      style: titleText,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Add Exercise Button
                  GestureDetector(
                    onTap: _addExercise,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        height: 40,
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
                  const SizedBox(height: 16),

                  // Exercises List
                  if (exercises.isNotEmpty)
                    Column(
                      children: [
                        for (int i = 0; i < exercises.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _exerciseCard(i),
                          ),
                      ],
                    ),
                  const SizedBox(height: 24),

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
                              onPressed: _saveWorkout,
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
                          'Deletar Treino',
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

  Widget _exerciseCard(int index) {
    final exercise = exercises[index];

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header com número e botão remover
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exercício ${index + 1}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => _removeExercise(index),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Nome do exercício
          TextField(
            controller: TextEditingController(text: exercise.name),
            onChanged: (value) {
              exercise.name = value;
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Nome do exercício',
              hintStyle: const TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          const SizedBox(height: 12),

          // Row com Séries, Repetições e Peso
          Row(
            children: [
              Expanded(
                child: _inputField(
                  'Séries',
                  exercise.sets?.toString() ?? '',
                  (value) {
                    exercise.sets = int.tryParse(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _inputField(
                  'Reps',
                  exercise.reps?.toString() ?? '',
                  (value) {
                    exercise.reps = int.tryParse(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _inputField(
                  'Peso (kg)',
                  exercise.weight?.toString() ?? '',
                  (value) {
                    exercise.weight = double.tryParse(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Campo de Isometria
          _inputField(
            'Isometria em segundos',
            exercise.isometrytime?.toString() ?? '',
            (value) {
              exercise.isometrytime = int.tryParse(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _inputField(
    String label,
    String value,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
      ],
    );
  }
}
