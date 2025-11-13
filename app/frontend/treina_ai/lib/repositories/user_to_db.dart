import '../models/user.dart';
import 'package:treina_ai/data/users_database.dart';

// conecta a UI com o database! Possui o crud basico, de adicionar, buscar e remover os usuarios do db.
class UserRepository{ 
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addUser(User user) async {
    await _dbHelper.insertUser(user);
  }

  Future<List<User>> fetchUsers() async {
    return await _dbHelper.getUsers();
  }

  Future<void> removeUser(String codUser) async {
    await _dbHelper.deleteUser(codUser);
  }
}