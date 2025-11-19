import 'package:sqflite/sqflite.dart';
import '../models/client.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import 'users_database.dart';

class ClientsDatabase {
  static final ClientsDatabase instance = ClientsDatabase._internal();
  ClientsDatabase._internal();

  Future<void> insertClient(Client client) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('clients', client.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Client>> getClients() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('clients');
    return maps.map((m) => Client.fromMap(m)).toList();
  }

  Future<List<Client>> getClientsByUser(int codUser) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('clients', where: 'codUser = ?', whereArgs: [codUser]);
    return maps.map((m) => Client.fromMap(m)).toList();
  }

  Future<Client?> getClientById(int codClient) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('clients', where: 'codClient = ?', whereArgs: [codClient]);
    if (maps.isNotEmpty) return Client.fromMap(maps.first);
    return null;
  }

  Future<void> updateClient(Client client) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('clients', client.toMap(), where: 'codClient = ?', whereArgs: [client.codClient]);
  }

  Future<void> deleteClient(int codClient) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('clients', where: 'codClient = ?', whereArgs: [codClient]);
  }

  // Period operations
  Future<void> insertPeriod(Period period) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('periods', period.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Period>> getPeriodsByClient(int codClient) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('periods', where: 'codClient = ?', whereArgs: [codClient]);
    return maps.map((m) => Period.fromMap(m)).toList();
  }

  Future<Period?> getPeriodById(int codPeriod) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('periods', where: 'codPeriod = ?', whereArgs: [codPeriod]);
    if (maps.isNotEmpty) return Period.fromMap(maps.first);
    return null;
  }

  Future<void> updatePeriod(Period period) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('periods', period.toMap(), where: 'codPeriod = ?', whereArgs: [period.codPeriod]);
  }

  Future<void> deletePeriod(int codPeriod) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('periods', where: 'codPeriod = ?', whereArgs: [codPeriod]);
  }

  // Workout operations
  Future<int> insertWorkout(Workout workout) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('workout', workout.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Workout>> getWorkoutsByPeriod(int codPeriod) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('workout', where: 'codPeriod = ?', whereArgs: [codPeriod], orderBy: 'date DESC');
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

  // Exercise operations
  Future<void> insertExercise(Exercise exercise) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('exercise', exercise.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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