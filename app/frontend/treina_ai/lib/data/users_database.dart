import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/client.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../models/exercise.dart';

//classe básica do database. Aqui define o statico inicial e o construtor privado
// fora que inicializa o banco (junto com o nome do arquivo) e cria a tabela
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB('treina_ai.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async { // Cria a tabela de usuários quando o db é criado! Acredito que seja apenas uma vez.
    await db.execute('''
      CREATE TABLE users (
        codUser INTEGER PRIMARY KEY AUTOINCREMENT,
        cref TEXT NOT NULL,
        name TEXT,
        contact TEXT
      )

      CREATE TABLE clients (
        codClient INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        desc TEXT,
        photoPath TEXT,
        age INTEGER,
        height REAL,
        weight REAL,
        gender TEXT,
        codUser INTEGER,
        FOREIGN KEY (codUser) REFERENCES users (codUser)
      )

      CREATE TABLE periods (
        codPeriod INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        objective TEXT,
        codClient INTEGER,
        FOREIGN KEY (codClient) REFERENCES clients (codClient)
      )

      CREATE TABLE workout (
        codWorkout INTEGER PRIMARY KEY AUTOINCREMENT,
        date DATE NOT NULL,
        notes TEXT,
        codPeriod INTEGER,
        FOREIGN KEY (codPeriod) REFERENCES periods (codPeriod)
      )

      CREATE TABLE exercise (
        codExercise INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        sets INTEGER,
        reps INTEGER,
        weight REAL,
        codWorkout INTEGER,
        FOREIGN KEY (codWorkout) REFERENCES workout (codWorkout)
      )
    ''');
  }

  // CRUD básico, feito apenas como placeholder por enquanto!
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return maps.map((m) => User.fromMap(m)).toList();
  }

  Future<void> deleteUser(String cref) async {
    final db = await database;
    await db.delete('users', where: 'cref = ?', whereArgs: [cref]);
  }

  Future<User?> getFirstUser() async {
    final db = await database;
    final maps = await db.query('users', limit: 1);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByCref(String cref) async {
    final db = await database;
    final maps = await db.query('users', where: 'cref = ?', whereArgs: [cref]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateUser(User user, String cref) async {
    final db = await database;
    await db.update('users', user.toMap(), where: 'cref = ?', whereArgs: [cref]);
  }

  // ===================== CLIENT CRUD =====================

  Future<void> insertClient(Client client) async {
    final db = await database;
    await db.insert('clients', client.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Client>> getClients() async {
    final db = await database;
    final maps = await db.query('clients');
    return maps.map((m) => Client.fromMap(m)).toList();
  }

  Future<List<Client>> getClientsByUser(int codUser) async {
    final db = await database;
    final maps = await db.query('clients', where: 'codUser = ?', whereArgs: [codUser]);
    return maps.map((m) => Client.fromMap(m)).toList();
  }

  Future<Client?> getClientById(int codClient) async {
    final db = await database;
    final maps = await db.query('clients', where: 'codClient = ?', whereArgs: [codClient]);
    if (maps.isNotEmpty) {
      return Client.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateClient(Client client) async {
    final db = await database;
    await db.update('clients', client.toMap(), where: 'codClient = ?', whereArgs: [client.codClient]);
  }

  Future<void> deleteClient(int codClient) async {
    final db = await database;
    await db.delete('clients', where: 'codClient = ?', whereArgs: [codClient]);
  }

  // ===================== PERIOD CRUD =====================

  Future<void> insertPeriod(Period period) async {
    final db = await database;
    await db.insert('periods', period.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Period>> getPeriods() async {
    final db = await database;
    final maps = await db.query('periods');
    return maps.map((m) => Period.fromMap(m)).toList();
  }

  Future<List<Period>> getPeriodsByClient(int codClient) async {
    final db = await database;
    final maps = await db.query('periods', where: 'codClient = ?', whereArgs: [codClient]);
    return maps.map((m) => Period.fromMap(m)).toList();
  }

  Future<Period?> getPeriodById(int codPeriod) async {
    final db = await database;
    final maps = await db.query('periods', where: 'codPeriod = ?', whereArgs: [codPeriod]);
    if (maps.isNotEmpty) {
      return Period.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updatePeriod(Period period) async {
    final db = await database;
    await db.update('periods', period.toMap(), where: 'codPeriod = ?', whereArgs: [period.codPeriod]);
  }

  Future<void> deletePeriod(int codPeriod) async {
    final db = await database;
    await db.delete('periods', where: 'codPeriod = ?', whereArgs: [codPeriod]);
  }

  // ===================== WORKOUT CRUD =====================

  Future<void> insertWorkout(Workout workout) async {
    final db = await database;
    await db.insert('workout', workout.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final maps = await db.query('workout');
    return maps.map((m) => Workout.fromMap(m)).toList();
  }

  Future<List<Workout>> getWorkoutsByPeriod(int codPeriod) async {
    final db = await database;
    final maps = await db.query('workout', where: 'codPeriod = ?', whereArgs: [codPeriod]);
    return maps.map((m) => Workout.fromMap(m)).toList();
  }

  Future<Workout?> getWorkoutById(int codWorkout) async {
    final db = await database;
    final maps = await db.query('workout', where: 'codWorkout = ?', whereArgs: [codWorkout]);
    if (maps.isNotEmpty) {
      return Workout.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateWorkout(Workout workout) async {
    final db = await database;
    await db.update('workout', workout.toMap(), where: 'codWorkout = ?', whereArgs: [workout.codWorkout]);
  }

  Future<void> deleteWorkout(int codWorkout) async {
    final db = await database;
    await db.delete('workout', where: 'codWorkout = ?', whereArgs: [codWorkout]);
  }

  // ===================== EXERCISE CRUD =====================

  Future<void> insertExercise(Exercise exercise) async {
    final db = await database;
    await db.insert('exercise', exercise.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Exercise>> getExercises() async {
    final db = await database;
    final maps = await db.query('exercise');
    return maps.map((m) => Exercise.fromMap(m)).toList();
  }

  Future<List<Exercise>> getExercisesByWorkout(int codWorkout) async {
    final db = await database;
    final maps = await db.query('exercise', where: 'codWorkout = ?', whereArgs: [codWorkout]);
    return maps.map((m) => Exercise.fromMap(m)).toList();
  }

  Future<Exercise?> getExerciseById(int codExercise) async {
    final db = await database;
    final maps = await db.query('exercise', where: 'codExercise = ?', whereArgs: [codExercise]);
    if (maps.isNotEmpty) {
      return Exercise.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateExercise(Exercise exercise) async {
    final db = await database;
    await db.update('exercise', exercise.toMap(), where: 'codExercise = ?', whereArgs: [exercise.codExercise]);
  }

  Future<void> deleteExercise(int codExercise) async {
    final db = await database;
    await db.delete('exercise', where: 'codExercise = ?', whereArgs: [codExercise]);
  }

  // ===================== UTILITY METHODS =====================

  /// Limpa todas as tabelas (útil para testes/debug)
  Future<void> resetDatabase() async {
    final db = await database;
    await db.delete('exercise');
    await db.delete('workout');
    await db.delete('periods');
    await db.delete('clients');
    await db.delete('users');
  }

}