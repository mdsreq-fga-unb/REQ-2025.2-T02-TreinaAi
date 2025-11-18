import 'package:sqflite/sqflite.dart';
import '../models/period.dart';
import 'users_database.dart';

class PeriodsDatabase {
  static final PeriodsDatabase instance = PeriodsDatabase._internal();
  PeriodsDatabase._internal();

  Future<void> insertPeriod(Period period) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('periods', period.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Period>> getPeriods() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('periods');
    return maps.map((m) => Period.fromMap(m)).toList();
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
}
