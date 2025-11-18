import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
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
      version: 1,
      onCreate: DatabaseSchema.onCreate,
    );
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

  Future<void> deleteUser(String codUser) async {
    final db = await database;
    await db.delete('users', where: 'codUser = ?', whereArgs: [codUser]);
  }

  Future<User?> getFirstUser() async {
    final db = await database;
    final maps = await db.query('users', limit: 1);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
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
    await db.update('users', user.toMap(), where: 'codUser = ?', whereArgs: [codUser]);
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