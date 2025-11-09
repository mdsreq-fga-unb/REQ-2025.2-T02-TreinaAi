import 'package:flutter/material.dart';
import 'components.dart';

class PeriodoPage extends StatefulWidget {
  const PeriodoPage({super.key});

  @override
  State<PeriodoPage> createState() => _PeriodoPageState();
}

class _PeriodoPageState extends State<PeriodoPage> {
  final List<String> treinos = [
    "Treino 23/04/2025",
    "Treino 29/04/2025",
    "Treino 06/05/2025",
    "Treino 10/05/2025",
  ];

  void adicionarTreino() {
    // Exemplo de ação
    setState(() {
      treinos.add("Treino ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "SETEMBRO",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Objetivo: Fortalecimento de quadríceps",
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 30),

            // Plano de Treino
            const Text(
              "Plano de Treino",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  text: "Baixar planilha",
                  color: const Color(0xFF0C1F28),
                  onPressed: () {
                    // Ação: baixar planilha
                  },
                ),
                AddSquareButton(
                  onPressed: () {
                    // Ação: adicionar planilha
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            const Text(
              "Treinos realizados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 12),

            // Botão de adicionar treino
            GestureDetector(
              onTap: adicionarTreino,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE67C5B)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Color(0xFFE67C5B)),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Lista de treinos
            for (var treino in treinos)
              TrainingButton(
                label: treino,
                onPressed: () {
                  // ação ao clicar em treino
                },
              ),

            const SizedBox(height: 20),

            // Botões de ação final
            CustomButton(
              text: "Gerar PDF",
              color: const Color(0xFF0C1F28),
              onPressed: () {
                // ação gerar PDF
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: "Fechar Período",
              color: const Color(0xFFA0162B),
              onPressed: () {
                // ação fechar período
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
