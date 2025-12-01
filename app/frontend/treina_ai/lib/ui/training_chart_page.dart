import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../data/clients_database.dart';

class TrainingChartPage extends StatefulWidget {
  final Period period;

  const TrainingChartPage({
    super.key,
    required this.period,
  });

  @override
  State<TrainingChartPage> createState() => _TrainingChartPageState();
}

// pega todas as informações de exercícios e treinos no perpríodo selecionado
class _TrainingChartPageState extends State<TrainingChartPage> {
  bool _loading = true;

  List<Workout> workouts = [];
  List<Exercise> allExercises = [];

  String? selectedExerciseName;
  List<String> exerciseNames = [];

  // Datas únicas (ordenadas) correspondentes ao exercício selecionado.
  // Usadas para rotular o eixo X (índices -> datas).
  List<DateTime> _currentDates = [];

  @override
  void initState() {
    super.initState();
    _loadPeriodData();
  }

  // Converte "dd/MM/yyyy" → DateTime(yyyy, mm, dd)
  // Retorna null se o formato for inválido
  DateTime? parseBrazilianDateSafe(String? input) {
    if (input == null) return null;
    try {
      final parts = input.split('/');
      if (parts.length != 3) return null;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  // Versão que assume entrada válida (uso interno quando já validamos)
  DateTime parseBrazilianDate(String input) {
    final maybe = parseBrazilianDateSafe(input);
    if (maybe != null) return maybe;
    // fallback seguro para evitar crash
    return DateTime(2000, 1, 1);
  }

  Future<void> _loadPeriodData() async {
    // limpar dados antes de carregar (evita duplicação se re-executado)
    workouts = [];
    allExercises = [];
    exerciseNames = [];
    selectedExerciseName = null;

    // 1 — Carregar os treinos do período selecionado (com base no codPeriod)
    workouts = await ClientsDatabase.instance
        .getWorkoutsByPeriod(widget.period.codPeriod!);

    // 2 — Carregar exercícios de todos os treinos
    for (var w in workouts) {
      final ex = await ClientsDatabase.instance
          .getExercisesByWorkout(w.codWorkout!);

      allExercises.addAll(ex);
    }

    // 3 — Obter lista única de nomes de exercícios
    exerciseNames = allExercises
        .map((e) => e.name)
        .toSet()
        .toList()
      ..sort();

    // 4 — Selecionar o primeiro automaticamente
    if (exerciseNames.isNotEmpty) {
      selectedExerciseName = exerciseNames.first;
    }

    setState(() => _loading = false);
  }

  // Acha o workout correspondente ao exercício
  Workout? _findWorkout(int codWorkout) {
    return workouts.firstWhere(
      (w) => w.codWorkout == codWorkout,
      orElse: () => Workout(
        codWorkout: 0,
        // fallback EM FORMATO BRASILEIRO (dd/MM/yyyy) para coerência com parse
        date: "01/01/2000",
        codPeriod: widget.period.codPeriod!,
      ),
    );
  }

  // Prepara os dados do gráfico: popula _currentDates (datas únicas ordenadas)
  // e retorna os spots usando índices (0,1,2...) para X, evitando buracos entre datas.
  // Constrói os pontos do gráfico para o exercício selecionado (peso X data real)
  List<FlSpot> _prepareChartData() {
    _currentDates = [];

    if (selectedExerciseName == null) return [];

    // Filtrar apenas o exercício selecionado
    final filtered = allExercises.where((e) => e.name == selectedExerciseName).toList();

    if (filtered.isEmpty) return [];

    // Ordenar pela data real do workout; usa parse seguro
    filtered.sort((a, b) {
      final wa = _findWorkout(a.codWorkout!)!;
      final wb = _findWorkout(b.codWorkout!)!;
      final da = parseBrazilianDateSafe(wa.date);
      final db = parseBrazilianDateSafe(wb.date);

      if (da == null && db == null) return 0;
      if (da == null) return 1; // coloca inválidos por último
      if (db == null) return -1;
      return da.compareTo(db);
    });

    // Extrair datas únicas (somente datas válidas, ignorando fallback/inválidas)
    final dateSet = <DateTime>{};
    for (final e in filtered) {
      final w = _findWorkout(e.codWorkout)!;
      final dt = parseBrazilianDateSafe(w.date);
      if (dt != null && !(dt.year == 2000 && dt.month == 1 && dt.day == 1)) {
        dateSet.add(DateTime(dt.year, dt.month, dt.day)); // normaliza sem hora
      }
    }

    _currentDates = dateSet.toList()..sort();

    // Se por algum motivo não houver datas válidas, não construir spots
    if (_currentDates.isEmpty) return [];

    // Constrói os pontos usando índices (posição da data em _currentDates)
    final spots = <FlSpot>[];
    for (final e in filtered) {
      final workout = _findWorkout(e.codWorkout!)!;
      final dt = parseBrazilianDateSafe(workout.date);

      // Ignora exercícios cujo workout não tem data válida
      if (dt == null) continue;

      final normalized = DateTime(dt.year, dt.month, dt.day);
      final x = _currentDates.indexOf(normalized);
      if (x < 0) continue; // por segurança

      final y = (e.weight ?? 0).toDouble();
      spots.add(FlSpot(x.toDouble(), y));
    }

    return spots;
  }

  // calcula o máximo peso (somente para o exercício selecionado)
  double _maxY() {
    if (selectedExerciseName == null) return 10;

    final values = allExercises
        .where((e) => e.name == selectedExerciseName)
        .map((e) => e.weight ?? 0)
        .toList();

    if (values.isEmpty) return 10;

    return values.reduce((a, b) => a > b ? a : b).toDouble() + 5;
  }

  // Formata a data para o eixo X (dd/MM)
  Widget _bottomTitleWidget(double value, TitleMeta meta) {
    final idx = value.toInt();
    if (idx < 0 || idx >= _currentDates.length) return const SizedBox.shrink();
    final date = _currentDates[idx];
    final formatted = "${date.day}/${date.month}";
    // SideTitleWidget's API changed in newer fl_chart releases and no longer
    // accepts `axisSide` as a named parameter; use Padding to provide spacing.
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(formatted, style: const TextStyle(fontSize: 10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prepara spots e datas atualizadas para renderização
    final spots = _prepareChartData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Gráficos do período: ${widget.period.title}"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : allExercises.isEmpty
              ? const Center(
                  child: Text(
                    "Nenhum exercício encontrado no período",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // -------- Dropdown de exercício -------- //
                      DropdownButtonFormField<String>(
                        value: selectedExerciseName,
                        items: exerciseNames
                            .map((name) => DropdownMenuItem(
                                  value: name,
                                  child: Text(name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedExerciseName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Selecionar exercício",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // -------- Gráfico -------- //
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1.5,
                          child: LineChart(
                            LineChartData(
                              minY: 0,
                              maxY: _maxY(),

                              // minX/maxX baseados no número de datas (0..n-1)
                              minX: spots.isEmpty ? 0 : 0,
                              maxX: spots.isEmpty ? 1 : (_currentDates.length - 1).toDouble(),

                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                horizontalInterval: 5,
                                getDrawingHorizontalLine: (_) =>
                                    const FlLine(color: Colors.grey, strokeWidth: 0.3),
                                getDrawingVerticalLine: (_) =>
                                    const FlLine(color: Colors.grey, strokeWidth: 0.3),
                              ),

                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 5,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        "${value.toInt()} kg",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    reservedSize: 36,
                                    getTitlesWidget: _bottomTitleWidget,
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),

                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  barWidth: 4,
                                  color: Colors.orange,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.orange.withOpacity(0.2),
                                  ),
                                  dotData: const FlDotData(show: true),
                                ),
                              ],

                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
