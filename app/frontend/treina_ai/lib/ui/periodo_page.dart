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
    setState(() {
      treinos.add(
        "Treino ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      );
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              children: [
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    "Objetivo: Fortalecimento de quadríceps",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                //lano de Treino
                const Text(
                  "Plano de Treino",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 12),

                //Botões lado a lado
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareActionButton(
                      text: "Baixar\nplanilha",
                      color: const Color(0xFF0C1F28),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 24),
                    AddSquareButton(
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                const Text(
                  "Treinos realizados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 12),

                //Botão adicionar treino
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

                //Lista de treinos
                for (var treino in treinos)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE67C5B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Text(
                        treino,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

              //Botões Gerar PDF e Fechar Período
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C1F28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Gerar PDF",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA0162B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Fechar Período",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
