// ============================================
//  TRAINING_PDF - COM GRÁFICO DE 3 LINHAS
//  (Opção 1 — Maior peso do dia por exercício)
// ============================================

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
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

class TrainingPDF extends StatefulWidget {
  final Period period;

  const TrainingPDF({super.key, required this.period});

  @override
  State<TrainingPDF> createState() => _TrainingPDFState();
}

class _TrainingPDFState extends State<TrainingPDF> {
  final db = ClientsDatabase.instance;
  final userDB = DatabaseHelper.instance;

  // ---------------------------- VARIÁVEIS GERAIS ----------------------------------
  // Listas que receberão os dados do banco
  // Síntese do período
  int totalWorkouts = 0;

  // Maior carga por exercício
  Map<String, double> maxWeight = {}; // <-- AQUI FICA O PESO MÁXIMO POR EXERCÍCIO
  // --------------------------

  List<Workout> workouts = [];
  List<User> trainers = [];
  List<Exercise> allExercises = [];

  DateTime? firstDate;
  DateTime? lastDate;

  // Contagem do exercício mais realizado
  Map<String, int> exerciseCount = {};
  Map<String, Map<DateTime, double>> exerciseDailyMax = {};

  final GlobalKey chartKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  DateTime parseBrazilianDate(String input) {
    final parts = input.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  Future<void> _loadAll() async {
    workouts = await db.getWorkoutsByPeriod(widget.period.codPeriod ?? 0);


    // pega os usuarios 
    final User? t = await userDB.getFirstUser();
    if (t != null) trainers = [t];

    List<Exercise> temp = [];
    for (var w in workouts) {
      final list = await db.getExercisesByWorkout(w.codWorkout ?? 0);
      temp.addAll(list);
    }
    allExercises = temp;

    _computeTop3DailyMax();
    setState(() {});
  }

    // ---------------------- TABELA DE TREINOS ---------------------------------------
  Widget _buildWorkoutTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Data")),
        DataColumn(label: Text("Exercícios")),
        DataColumn(label: Text("Carga Total")),
      ],
      rows: workouts.map((w) {
        final ex = allExercises.where((e) => e.codWorkout == w.codWorkout);

        final cargaTotal =
            ex.fold<double>(0, (sum, item) => sum + (item.weight ?? 0));

        return DataRow(
          cells: [
            DataCell(Text(w.date)),
            DataCell(Text(ex.length.toString())),
            DataCell(Text("${cargaTotal.toStringAsFixed(1)} kg")), // <-- AQUI ESTÁ A CARGA TOTAL DO TREINO
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSummaryWidget() {
    final totalWorkouts = workouts.length;
    final totalExercises = allExercises.length;
    final totalCarga = allExercises.fold<double>(0, (sum, item) => sum + (item.weight ?? 0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total de Treinos: $totalWorkouts", style: const TextStyle(fontSize: 16)),
        Text("Total de Exercícios: $totalExercises", style: const TextStyle(fontSize: 16)),
        Text("Carga Total Levantada: ${totalCarga.toStringAsFixed(1)} kg", style: const TextStyle(fontSize: 16)),
      ],
    ); // column
  } 

  // =====================================================
  // TOP 3 EXERCÍCIOS + MAIOR PESO DO DIA
  // =====================================================
  void _computeTop3DailyMax() {
    exerciseCount = {};

    // Contagem de ocorrências por NOME
    for (var e in allExercises) {
      exerciseCount[e.name] = (exerciseCount[e.name] ?? 0) + 1;
    }

    // Pegamos os 3 mais realizados
    final top3 = exerciseCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final selected = top3.take(3).map((e) => e.key).toList();

    exerciseDailyMax = {
      for (var name in selected) name: {}
    };

    // Agrupar por nome + data -> maior peso do dia
    for (var e in allExercises) {
      if (!exerciseDailyMax.containsKey(e.name)) continue;

      // Obter a string de data associada ao exercício:
      // 1) tentar pegar a data no treino (Workout) associado ao exercício;
      // 2) se não houver, tentar propriedades comuns dinamicamente no Exercise;
      // 3) fallback para a data atual.
      String dateString = '';

      try {
        final dyn = e as dynamic;

        // tentar localizar o treino associado (caso Exercise mantenha codWorkout)
        Workout? associatedWorkout;
        try {
          associatedWorkout = workouts.firstWhere((w) => w.codWorkout == dyn.codWorkout);
        } catch (_) {
          associatedWorkout = null;
        }

        if (associatedWorkout != null) {
          // assume-se que Workout.date existe no formato "dd/MM/yyyy"
          dateString = associatedWorkout.date ?? '';
        }

        // se não encontrou ainda, tentar campos possíveis no Exercise via dynamic
        if (dateString.isEmpty) {
          if (dyn.date != null) dateString = dyn.date;
          else if (dyn.dateString != null) dateString = dyn.dateString;
          else if (dyn.data != null) dateString = dyn.data;
        }
      } catch (_) {
        // qualquer erro aqui será tratado pelo fallback abaixo
      }

      // fallback para data atual caso não haja informação
      if (dateString.isEmpty) {
        final now = DateTime.now();
        dateString = "${now.day}/${now.month}/${now.year}";
      }

      final DateTime d = parseBrazilianDate(dateString);
      final double peso = (e.weight ?? 0).toDouble();

      if (!exerciseDailyMax[e.name]!.containsKey(d) ||
          peso > exerciseDailyMax[e.name]![d]!) {
        exerciseDailyMax[e.name]![d] = peso;
      }
    }

    // Garantir datas em ordem
    for (var key in exerciseDailyMax.keys) {
      final sorted = Map.fromEntries(
        exerciseDailyMax[key]!.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)),
      );
      exerciseDailyMax[key] = sorted;
    }
  }

  // GERA SPOTS PARA O GRÁFICO
  List<LineChartBarData> _buildLines() {
    List<LineChartBarData> lines = [];

    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
    ];

    int index = 0;

    exerciseDailyMax.forEach((name, data) {
      final spots = <FlSpot>[];
      int x = 0;

      data.forEach((date, weight) {
        spots.add(FlSpot(x.toDouble(), weight));
        x++;
      });

      lines.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 3,
          color: colors[index % colors.length],
        ),
      );

      index++;
    });

    return lines;
  }

  // TEXTO DA LEGENDA
  Widget _buildLegend() {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
    ];

    int i = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: exerciseDailyMax.keys.map((name) {
        final c = colors[i % colors.length];
        i++;
        return Row(
          children: [
            Container(width: 15, height: 15, color: c),
            const SizedBox(width: 8),
            Text(name, style: const TextStyle(fontSize: 14)),
          ],
        );
      }).toList(),
    );
  }

  // =====================================================
  // GERAR PDF
  // =====================================================
  Future<void> _generatePDF() async {
    RenderRepaintBoundary boundary =
        chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image img = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    Uint8List chartBytes = byteData!.buffer.asUint8List();

    final PdfDocument document = PdfDocument();
    final page = document.pages.add();

    final titleFont =
        PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);

    double y = 0;

          // ------------------------------------------------------------------
    //                   SEÇÃO DO TREINADOR (ARRUMADA PÓS CAGADA Q EU FIZ)
    // ------------------------------------------------------------------

    // Carregar imagem do logo
    final ByteData logoBytes = await rootBundle.load("assets/logo.png");
    final Uint8List logoData = logoBytes.buffer.asUint8List();
    final PdfBitmap logoBitmap = PdfBitmap(logoData);

    // Dados do treinador
    final User? t = trainers.isNotEmpty ? trainers.first : null;
    final String trainerName = t?.name ?? "Treinador";
    final String trainerCref = (t != null && t.cref.trim().isNotEmpty) ? "CREF: ${t.cref}" : "";
    final String trainerContact = (t != null && t.contact.trim().isNotEmpty) ? "Contato: ${t.contact}" : "";
    final textFont = PdfStandardFont(PdfFontFamily.helvetica, 14);


    // Fundo decorativo
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 200, 80)),
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 140),
    );

    // Caixa branca do texto
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(10, y + 10, page.getClientSize().width - 140, 110),
    );

    // Logo
    page.graphics.drawImage(
      logoBitmap,
      Rect.fromLTWH(page.getClientSize().width - 120, y + 10, 110, 110),
    );

    // Título
      page.graphics.drawString(
        "Personal",
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(120, 40, 20)), // tom vinho igual ao logo
        bounds: Rect.fromLTWH(20, y + 15, 400, 30),
      );

    // nome

        page.graphics.drawString(
      "Nome: $trainerName",
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: Rect.fromLTWH(20, y + 50, 400, 20),
    );

    // CREF (se existir)
    if (trainerCref.isNotEmpty) {
      page.graphics.drawString(
        trainerCref,
        PdfStandardFont(PdfFontFamily.helvetica, 14),
        bounds: Rect.fromLTWH(20, y + 70, 400, 20),
      );
    }

    // Contato (se existir)
    if (trainerContact.isNotEmpty) {
      page.graphics.drawString(
        trainerContact,
        PdfStandardFont(PdfFontFamily.helvetica, 14),
        bounds: Rect.fromLTWH(20, y + 90, 400, 20),
      );
    }

    y += 160;

    // ---- TÍTULO ----
    page.graphics.drawString(
      "Evolução dos Exercícios",
      titleFont,
      bounds: Rect.fromLTWH(0, y, 500, 30),
    );
    y += 40;

    // ---- GRÁFICO ----
    page.graphics.drawImage(
      PdfBitmap(chartBytes),
      Rect.fromLTWH(0, y, 500, 280),
    );
    y += 300;

    // ---- LEGENDA ----
   final legend = exerciseDailyMax.keys.join(" | ");

    page.graphics.drawString(
      "Legenda: $legend",
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: Rect.fromLTWH(0, y, 500, 40),
    );

    y += 40;

    // ---- RESUMO ----
    final resumoTitleFont = PdfStandardFont(PdfFontFamily.helvetica, 18);
      
    // Adiciona o título do resumo, usando o 'y' atualizado
    page.graphics.drawString(
      'Resumo:',
      resumoTitleFont,
      bounds: Rect.fromLTWH(0, y, 300, 20),
    );

    y += 25;

    // Exemplo: variável mostTrained deve vir de onde você já usa no widget
  final String mostTrained = exerciseCount.isEmpty
      ? "-"
      : exerciseCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  String resumoTexto =
      "Total de treinos: $totalWorkouts\n"
      "Início: ${firstDate != null ? "${firstDate!.day}/${firstDate!.month}/${firstDate!.year}" : "-"}\n"
      "Fim: ${lastDate != null ? "${lastDate!.day}/${lastDate!.month}/${lastDate!.year}" : "-"}\n"
      "Exercício mais treinado: $mostTrained";

  page.graphics.drawString(
    resumoTexto,
    textFont,
    bounds: Rect.fromLTWH(0, y, 500, 200),
  );

    final List<int> bytes = await document.save();
    document.dispose();

    await saveAndOpenFile(bytes, 'relatorio_treino.pdf');
  }

  // =====================================================
  // TELA PRINCIPAL
  // =====================================================
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 236, 236, 236),
    appBar: AppBar(
      title: Text(widget.period.title ?? ""),
    ),
    body: allExercises.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Evolução dos 3 exercícios mais realizados",
                  style: TextStyle(
                    color: Color.fromARGB(255, 241, 154, 23),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),

                // ======================
                // GRÁFICO
                // ======================
                RepaintBoundary(
  key: chartKey,
  child: SizedBox(
    height: 300,
    child: LineChart(
      LineChartData(
        lineBarsData: _buildLines(),
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      interval: 10,
      reservedSize: 40,
      getTitlesWidget: (value, meta) {
        return Text(
          "${value.toInt()} kg",
          style: const TextStyle(fontSize: 10),
        );
      },
    ),
  ),

  // REMOVER OS NÚMEROS DO TOPO
  topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),

  // REMOVER OS NÚMEROS NA DIREITA
  rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),

  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        final int idx = value.toInt();
        final allDates = exerciseDailyMax.values
            .expand((m) => m.keys)
            .toSet()
            .toList()
          ..sort();

        if (idx < 0 || idx >= allDates.length) {
          return const SizedBox.shrink();
        }

        final d = allDates[idx];
        return Text(
          "${d.day}/${d.month}",
          style: const TextStyle(fontSize: 10),
        );
      },
    ),
  ),
        ),
      ),
    ),
  ),
),

                const SizedBox(height: 20),

                // ======================
                // LEGENDA do infernoooooooooooooooooo
                // ======================
                _buildLegend(),

                const SizedBox(height: 40),

                // ======================
                // BOTÃO DE PDF
                // ======================
                ElevatedButton(
                  onPressed: _generatePDF,
                  child: const Text(
                    "Gerar PDF",
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 155, 47),
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ======================
                // RESUMO DO PERÍODO
                // ======================
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Resumo do período",
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 155, 47),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSummaryWidget(),
                const SizedBox(height: 40),

                // ======================
                // TABELA DE TREINOS
                // ======================
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tabela de treinos",
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 155, 47),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildWorkoutTable(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
  );
}}