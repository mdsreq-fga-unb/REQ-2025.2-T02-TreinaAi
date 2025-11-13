import 'package:sqflite/sqflite.dart';
import '../models/client.dart';
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
}
