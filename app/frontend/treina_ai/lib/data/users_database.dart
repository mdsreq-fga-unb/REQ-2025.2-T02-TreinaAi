import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

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
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cref TEXT NOT NULL,
        name TEXT,
        contato TEXT
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

}