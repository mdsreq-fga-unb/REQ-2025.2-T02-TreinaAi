import '../models/workout.dart';
import 'package:treina_ai/data/users_database.dart';

// conecta a UI com o database para gerenciar Workouts
class WorkoutRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addWorkout(Workout workout) async {
    await _dbHelper.insertWorkout(workout);
  }

  Future<List<Workout>> fetchWorkouts() async {
    return await _dbHelper.getWorkouts();
  }

  Future<List<Workout>> fetchWorkoutsByPeriod(int codPeriod) async {
    return await _dbHelper.getWorkoutsByPeriod(codPeriod);
  }

  Future<Workout?> fetchWorkoutById(int codWorkout) async {
    return await _dbHelper.getWorkoutById(codWorkout);
  }

  Future<void> updateWorkout(Workout workout) async {
    await _dbHelper.updateWorkout(workout);
  }

  Future<void> removeWorkout(int codWorkout) async {
    await _dbHelper.deleteWorkout(codWorkout);
  }
}
