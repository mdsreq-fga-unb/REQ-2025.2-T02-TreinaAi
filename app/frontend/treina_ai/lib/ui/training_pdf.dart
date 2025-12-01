import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';   // PDF
import 'dart:ui' as ui;
import '../utils/save_and_open_file.dart';
import '../data/clients_database.dart';
import '../data/users_database.dart';
import '../models/period.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import '../models/user.dart';

User? trainer;

class TrainingPDF extends StatefulWidget {
  final Period period;

  const TrainingPDF({super.key, required this.period});

  @override
  State<TrainingPDF> createState() => _TrainingChartPageState();
}

class _TrainingChartPageState extends State<TrainingPDF> {
  final db = ClientsDatabase.instance;

  // ---------------------------- VARIÁVEIS GERAIS ----------------------------------
  // Listas que receberão os dados do banco
  List<Workout> workouts = [];
  List<Exercise> allExercises = [];

  // Síntese do período
  int totalWorkouts = 0;
  DateTime? firstDate;
  DateTime? lastDate;

  // Contagem do exercício mais realizado
  Map<String, int> exerciseCount = {};

  // Maior carga por exercício
  Map<String, double> maxWeight = {}; // <-- AQUI FICA O PESO MÁXIMO POR EXERCÍCIO
  // -------------------------------------------------------------------------------


  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    // Carrega todos os treinos do período
    workouts = await db.getWorkoutsByPeriod(widget.period.codPeriod ?? 0);

    // Carrega todos os exercícios de todos os treinos
    List<Exercise> temp = [];
    for (var w in workouts) {
      final list = await db.getExercisesByWorkout(w.codWorkout ?? 0);
      temp.addAll(list);
    }
    allExercises = temp;

    _buildSummary();
    setState(() {});
  }

  // ---------------------- CONSTRUÇÃO DA SÍNTESE -----------------------------------
  void _buildSummary() {
    totalWorkouts = workouts.length;

    // Datas
    List<DateTime> validDates = workouts
        .map((w) => DateTime.tryParse(w.date))
        .where((d) => d != null)
        .cast<DateTime>()
        .toList()
      ..sort();

    if (validDates.isNotEmpty) {
      firstDate = validDates.first;
      lastDate = validDates.last;
    }

    // Contagem de exercícios
    exerciseCount = {};
    for (var ex in allExercises) {
      exerciseCount[ex.name] = (exerciseCount[ex.name] ?? 0) + 1;
    }

    // Maior peso por exercício
    maxWeight = {};
    for (var e in allExercises) {
      double w = (e.weight ?? 0).toDouble();   // <-- AQUI ESTÁ O PESO EM KG DO EXERCÍCIO
      if (!maxWeight.containsKey(e.name) || w > maxWeight[e.name]!) {
        maxWeight[e.name] = w;
      }
    }
  }
  // ---------------------------------------------------------------------------------


  // ---------------------- WIDGET DE RESUMO -----------------------------------------
Widget _buildSummaryWidget() {
  // Função para converter "dd/MM/yyyy" em DateTime
  DateTime parseBrazilianDate(String input) {
    final parts = input.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  // Converter todas as datas dos workouts
  final List<DateTime> dates = workouts
      .map((w) => parseBrazilianDate(w.date))
      .toList()
    ..sort();

  // Definindo início e fim
  final DateTime? firstDate = dates.isNotEmpty ? dates.first : null;
  final DateTime? lastDate = dates.isNotEmpty ? dates.last : null;

  // Exercício mais treinado
  String mostTrained = exerciseCount.isEmpty
      ? "-"
      : exerciseCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Total de treinos: $totalWorkouts"),
      if (firstDate != null)
        Text("Início: ${firstDate.day}/${firstDate.month}/${firstDate.year}"),
      if (lastDate != null)
        Text("Fim: ${lastDate.day}/${lastDate.month}/${lastDate.year}"),
      Text("Exercício mais treinado: $mostTrained"),
    ],
  );
}


  // --------------------------------------------------------------------------------


  // ---------------------- TABELA DE TREINOS ---------------------------------------
  Widget _buildWorkoutTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Data")),
        DataColumn(label: Text("Séries")),
        DataColumn(label: Text("Carga Total")),
      ],
      rows: workouts.map((w) {
        final ex = allExercises.where((e) => e.codWorkout == w.codWorkout);

        final totalWeight = ex.fold<double>(0, (sum, item) => sum + (item.weight ?? 0));
        final count = ex.length;

        final cargaMedia = count > 0 ? totalWeight / count : 0;

        return DataRow(
          cells: [
            DataCell(Text(w.date)),
            DataCell(Text(ex.length.toString())),
            DataCell(Text("${cargaMedia.toStringAsFixed(1)} kg")), // <-- AQUI ESTÁ A CARGA TOTAL DO TREINO
          ],
        );
      }).toList(),
    );
  }
  // --------------------------------------------------------------------------------


  // ---------------------- GRÁFICO DE CARGA TOTAL ---------------------------------
  List<FlSpot> _spots() {
    // aqui eu to confuso sobre qual a métrica exata do gráfico. Dêem uma olhada depois!
    List<double> cargas = workouts.map((w) {
      final ex = allExercises.where((e) => e.codWorkout == w.codWorkout);
      return ex.fold<double>(0, (sum, e) {
          final peso = e.weight ?? 0;
          final repeticoes = e.sets ?? 1;   
          return sum + (peso * repeticoes);
        });
    }).toList();

    List<FlSpot> spots = [];

    for (int i = 0; i < cargas.length; i++) {
      spots.add(FlSpot(i.toDouble(), cargas[i]));
    }

    return spots;
  }

  final GlobalKey chartKey = GlobalKey();
  // -------------------------------------------------------------------------------



  // ---------------------- FUNÇÃO PARA GERAR O PDF --------------------------------
  Future<void> _generatePDF() async {
  DateTime parseBrazilianDate(String input) {
    final parts = input.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  // ---- CONVERTENDO E ORGANIZANDO AS DATAS ----
  final List<DateTime> dates = workouts
      .map((w) => parseBrazilianDate(w.date))
      .toList()
    ..sort();

  final DateTime? firstDate = dates.isNotEmpty ? dates.first : null;
  final DateTime? lastDate = dates.isNotEmpty ? dates.last : null;

  // ---- CAPTURA DO GRÁFICO COMO IMAGEM ----
  RenderRepaintBoundary boundary =
      chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image img = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  Uint8List chartBytes = byteData!.buffer.asUint8List();

  // ---- CRIAÇÃO DO PDF ----
  final PdfDocument document = PdfDocument();
  final page = document.pages.add();

  final titleFont =
      PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);
  final sectionFont =
      PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);
  final textFont = PdfStandardFont(PdfFontFamily.helvetica, 14);

  double y = 0;

  // ------------------------------------------------------------------
  // TREINADOR DEPOIS AQUI
  // ------------------------------------------------------------------

  // ---- FRASE DO PERÍODO ----
  page.graphics.drawString(
    "Aqui está o resumo do período ${widget.period.title}",
    titleFont,
    bounds: Rect.fromLTWH(0, y, 500, 30),
  );
  y += 40;

  // ---- IMAGEM COM O GRÁFICO ----
  page.graphics.drawImage(
    PdfBitmap(chartBytes),
    Rect.fromLTWH(0, y, 500, 260),
  );
  y += 280;

  // ---- RESUMO ----
  page.graphics.drawString(
    "Resumo:",
    sectionFont,
    bounds: Rect.fromLTWH(0, y, 500, 30),
  );
  y += 35;

  // Exemplo: variável mostTrained deve vir de onde você já usa no widget
  final String mostTrained = exerciseCount.isEmpty
      ? "-"
      : exerciseCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  String resumoTexto =
      "Total de treinos: $totalWorkouts\n"
      "Início: ${firstDate != null ? "${firstDate.day}/${firstDate.month}/${firstDate.year}" : "-"}\n"
      "Fim: ${lastDate != null ? "${lastDate.day}/${lastDate.month}/${lastDate.year}" : "-"}\n"
      "Exercício mais treinado: $mostTrained";

  page.graphics.drawString(
    resumoTexto,
    textFont,
    bounds: Rect.fromLTWH(0, y, 500, 200),
  );

  // ---- EXPORTA O PDF ----
  final List<int> bytes = await document.save();
  document.dispose();

  await saveAndOpenFile(bytes, 'relatorio_treino.pdf');
}

  // -------------------------------------------------------------------------------



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        title: Text(widget.period.title ?? ""),
      ),
      body: workouts.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Evolução da carga total por treino",
                    style: TextStyle(color: Color.fromARGB(255, 241, 154, 23), fontSize: 18),
                  ),
                  const SizedBox(height: 20),

                  // GRÁFICO
                  RepaintBoundary(
                    key: chartKey,
                    child: SizedBox(
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: true),
                          titlesData: const FlTitlesData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _spots(),
                              isCurved: true,
                              barWidth: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // RESUMO
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Resumo do período",
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryWidget(),
                  const SizedBox(height: 40),

                  // TABELA
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tabela de treinos",
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildWorkoutTable(),
                  ),

                  const SizedBox(height: 40),

                  // BOTÃO GERAR PDF
                  ElevatedButton(
                    onPressed: _generatePDF,
                    child: const Text(
                      "Gerar PDF",
                      style: TextStyle(color: Color.fromARGB(255, 237, 155, 47), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
