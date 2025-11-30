import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/client.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import 'database_schema.dart';

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
      version: 6,
      onCreate: DatabaseSchema.onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // adiciona a coluna isometrytime na tabela exercise | serve pra quem estiver com banco desatualziado
      await db.execute('ALTER TABLE exercise ADD COLUMN isometrytime INTEGER');
    }
    if (oldVersion < 3) {
      // adiciona a coluna isActive na tabela clients
      await db.execute('ALTER TABLE clients ADD COLUMN isActive INTEGER DEFAULT 1');
    }
    if (oldVersion < 4) {
      // adiciona a coluna observations na tabela periods
      await db.execute('ALTER TABLE periods ADD COLUMN observations TEXT');
    }
    if (oldVersion < 5) {
      // adiciona a coluna isClosed na tabela periods
      await db.execute('ALTER TABLE periods ADD COLUMN isClosed INTEGER DEFAULT 0');
    }
    if (oldVersion < 6) {
      // adiciona a coluna worksheetPath na tabela periods
      await db.execute('ALTER TABLE periods ADD COLUMN worksheetPath TEXT');
    }
  }

  // CRUD operations
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return maps.map((m) => User.fromMap(m)).toList();
  }

  Future<void> deleteUser(String codUser) async {
    final db = await database;
    await db.delete('users', where: 'codUser = ?', whereArgs: [codUser]);
  }

  Future<User?> getFirstUser() async {
    final db = await database;
    final maps = await db.query('users', limit: 1);
    if (maps.isNotEmpty) {
      final user = User.fromMap(maps.first);
      return user;
    }
    return null;
  }

  Future<User?> getUserByCref(String codUser) async {
    final db = await database;
    final maps = await db.query('users', where: 'codUser = ?', whereArgs: [codUser]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateUser(User user, String codUser) async {
    final db = await database;
    final codUserInt = int.tryParse(codUser) ?? 1;
    
    await db.update(
      'users', 
      user.toMap(), 
      where: 'codUser = ?', 
      whereArgs: [codUserInt]
    );
  }

  // ===================== CLIENT OPERATIONS =====================

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
    await db.update(
      'clients',
      client.toMap(),
      where: 'codClient = ?',
      whereArgs: [client.codClient],
    );
  }

  Future<void> deleteClient(int codClient) async {
    final db = await database;
    await db.delete('clients', where: 'codClient = ?', whereArgs: [codClient]);
  }

  // ===================== PERIOD OPERATIONS =====================

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
    await db.update(
      'periods',
      period.toMap(),
      where: 'codPeriod = ?',
      whereArgs: [period.codPeriod],
    );
  }

  Future<void> deletePeriod(int codPeriod) async {
    final db = await database;
    await db.delete('periods', where: 'codPeriod = ?', whereArgs: [codPeriod]);
  }

  // ===================== WORKOUT OPERATIONS =====================

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
    await db.update(
      'workout',
      workout.toMap(),
      where: 'codWorkout = ?',
      whereArgs: [workout.codWorkout],
    );
  }

  Future<void> deleteWorkout(int codWorkout) async {
    final db = await database;
    await db.delete('workout', where: 'codWorkout = ?', whereArgs: [codWorkout]);
  }

  // ===================== EXERCISE OPERATIONS =====================

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
    await db.update(
      'exercise',
      exercise.toMap(),
      where: 'codExercise = ?',
      whereArgs: [exercise.codExercise],
    );
  }

  Future<void> deleteExercise(int codExercise) async {
    final db = await database;
    await db.delete('exercise', where: 'codExercise = ?', whereArgs: [codExercise]);
  }

  // ===================== UTILITY METHODS =====================

  /// Limpa todas as tabelas (útil para testes/debug)
  Future<void> resetDatabase() async {
    final db = await database;
    await DatabaseSchema.resetAllTables(db);
  }

  /// Limpa apenas tabelas de treino
  Future<void> resetWorkoutData() async {
    final db = await database;
    await DatabaseSchema.resetWorkoutTables(db);
  }

  /// Limpa apenas clientes e seus treinos
  Future<void> resetClientData() async {
    final db = await database;
    await DatabaseSchema.resetClientTables(db);
  }

}