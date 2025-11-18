import '../models/exercise.dart';
import 'package:treina_ai/data/users_database.dart';

// conecta a UI com o database para gerenciar Exercises
class ExerciseRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addExercise(Exercise exercise) async {
    await _dbHelper.insertExercise(exercise);
  }

  Future<List<Exercise>> fetchExercises() async {
    return await _dbHelper.getExercises();
  }

  Future<List<Exercise>> fetchExercisesByWorkout(int codWorkout) async {
    return await _dbHelper.getExercisesByWorkout(codWorkout);
  }

  Future<Exercise?> fetchExerciseById(int codExercise) async {
    return await _dbHelper.getExerciseById(codExercise);
  }

  Future<void> updateExercise(Exercise exercise) async {
    await _dbHelper.updateExercise(exercise);
  }

  Future<void> removeExercise(int codExercise) async {
    await _dbHelper.deleteExercise(codExercise);
  }
}
