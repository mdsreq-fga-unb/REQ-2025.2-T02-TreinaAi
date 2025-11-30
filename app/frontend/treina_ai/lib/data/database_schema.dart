import 'package:sqflite/sqflite.dart';

/// Classe responsável pela criação e gerenciamento do schema do banco de dados
class DatabaseSchema {
  /// Cria todas as tabelas do banco de dados
  static Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        codUser INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        cref TEXT,
        contact TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE clients (
        codClient INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        desc TEXT,
        photoPath TEXT,
        age INTEGER,
        height REAL,
        weight REAL,
        gender TEXT,
        isActive INTEGER DEFAULT 1,
        codUser INTEGER,
        FOREIGN KEY (codUser) REFERENCES users (codUser)
      )
    ''');

    await db.execute('''
      CREATE TABLE periods (
        codPeriod INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        objective TEXT,
        observations TEXT,
        isClosed INTEGER DEFAULT 0,
        codClient INTEGER,
        FOREIGN KEY (codClient) REFERENCES clients (codClient)
      )
    ''');

    await db.execute('''
      CREATE TABLE workout (
        codWorkout INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        notes TEXT,
        codPeriod INTEGER,
        FOREIGN KEY (codPeriod) REFERENCES periods (codPeriod)
      )
    ''');

    await db.execute('''
      CREATE TABLE exercise (
        codExercise INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        sets INTEGER,
        reps INTEGER,
        weight REAL,
        isometrytime INTEGER,
        codWorkout INTEGER,
        FOREIGN KEY (codWorkout) REFERENCES workout (codWorkout)
      )
    ''');
  }

  /// Limpa todas as tabelas (útil para testes/debug)
  static Future<void> resetAllTables(Database db) async {
    await db.delete('exercise');
    await db.delete('workout');
    await db.delete('periods');
    await db.delete('clients');
    await db.delete('users');
  }

  /// Limpa apenas tabelas de treino (útil para reset parcial)
  static Future<void> resetWorkoutTables(Database db) async {
    await db.delete('exercise');
    await db.delete('workout');
    await db.delete('periods');
  }

  /// Limpa apenas clientes e suas relações em cascata
  static Future<void> resetClientTables(Database db) async {
    await db.delete('exercise');
    await db.delete('workout');
    await db.delete('periods');
    await db.delete('clients');
  }

  /// Limpa apenas usuários (cuidado: cascata pode afetar tudo)
  static Future<void> resetUsers(Database db) async {
    await db.delete('users');
  }
}
