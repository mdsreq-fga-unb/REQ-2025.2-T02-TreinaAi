import 'package:sqflite/sqflite.dart';
import '../models/exercise.dart';
import 'users_database.dart';

class ExercisesDatabase {
  static final ExercisesDatabase instance = ExercisesDatabase._internal();
  ExercisesDatabase._internal();

  Future<void> insertExercise(Exercise exercise) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('exercise', exercise.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Exercise>> getExercises() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('exercise');
    return maps.map((m) => Exercise.fromMap(m)).toList();
  }

  Future<List<Exercise>> getExercisesByWorkout(int codWorkout) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('exercise', where: 'codWorkout = ?', whereArgs: [codWorkout]);
    return maps.map((m) => Exercise.fromMap(m)).toList();
  }

  Future<Exercise?> getExerciseById(int codExercise) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('exercise', where: 'codExercise = ?', whereArgs: [codExercise]);
    if (maps.isNotEmpty) return Exercise.fromMap(maps.first);
    return null;
  }

  Future<void> updateExercise(Exercise exercise) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('exercise', exercise.toMap(), where: 'codExercise = ?', whereArgs: [exercise.codExercise]);
  }

  Future<void> deleteExercise(int codExercise) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('exercise', where: 'codExercise = ?', whereArgs: [codExercise]);
  }
}
