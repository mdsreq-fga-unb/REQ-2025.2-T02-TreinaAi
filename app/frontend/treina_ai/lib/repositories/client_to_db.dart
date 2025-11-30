import '../models/client.dart';
import 'package:treina_ai/data/users_database.dart';

// conecta a UI com o database para gerenciar Clients
class ClientRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addClient(Client client) async {
    await _dbHelper.insertClient(client);
  }

  Future<List<Client>> fetchClients() async {
    return await _dbHelper.getClients();
  }

  Future<List<Client>> fetchClientsByUser(int codUser) async {
    return await _dbHelper.getClientsByUser(codUser);
  }

  Future<Client?> fetchClientById(int codClient) async {
    return await _dbHelper.getClientById(codClient);
  }

  Future<void> updateClient(Client client) async {
    await _dbHelper.updateClient(client);
  }

  Future<void> removeClient(int codClient) async {
    await _dbHelper.deleteClient(codClient);
  }
}
