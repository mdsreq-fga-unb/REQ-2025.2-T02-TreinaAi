import '../models/period.dart';
import 'package:treina_ai/data/users_database.dart';

// conecta a UI com o database para gerenciar Periods
class PeriodRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addPeriod(Period period) async {
    await _dbHelper.insertPeriod(period);
  }

  Future<List<Period>> fetchPeriods() async {
    return await _dbHelper.getPeriods();
  }

  Future<List<Period>> fetchPeriodsByClient(int codClient) async {
    return await _dbHelper.getPeriodsByClient(codClient);
  }

  Future<Period?> fetchPeriodById(int codPeriod) async {
    return await _dbHelper.getPeriodById(codPeriod);
  }

  Future<void> updatePeriod(Period period) async {
    await _dbHelper.updatePeriod(period);
  }

  Future<void> removePeriod(int codPeriod) async {
    await _dbHelper.deletePeriod(codPeriod);
  }
}
