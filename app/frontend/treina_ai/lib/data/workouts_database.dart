import 'package:sqflite/sqflite.dart';
import '../models/workout.dart';
import 'users_database.dart';

class WorkoutsDatabase {
  static final WorkoutsDatabase instance = WorkoutsDatabase._internal();
  WorkoutsDatabase._internal();

  Future<void> insertWorkout(Workout workout) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('workout', workout.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('workout');
    return maps.map((m) => Workout.fromMap(m)).toList();
  }

  Future<List<Workout>> getWorkoutsByPeriod(int codPeriod) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('workout', where: 'codPeriod = ?', whereArgs: [codPeriod]);
    return maps.map((m) => Workout.fromMap(m)).toList();
  }

  Future<Workout?> getWorkoutById(int codWorkout) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('workout', where: 'codWorkout = ?', whereArgs: [codWorkout]);
    if (maps.isNotEmpty) return Workout.fromMap(maps.first);
    return null;
  }

  Future<void> updateWorkout(Workout workout) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('workout', workout.toMap(), where: 'codWorkout = ?', whereArgs: [workout.codWorkout]);
  }

  Future<void> deleteWorkout(int codWorkout) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('workout', where: 'codWorkout = ?', whereArgs: [codWorkout]);
  }
}
