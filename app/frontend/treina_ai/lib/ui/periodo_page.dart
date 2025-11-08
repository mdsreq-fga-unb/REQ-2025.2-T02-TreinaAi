import 'package:flutter/material.dart';
import 'components.dart';

class PeriodoPage extends StatelessWidget {
  const PeriodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Center(
              child: Column(
                children: [
                  Text('SETEMBRO',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Objetivo: Fortalecimento de quadríceps',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black54, height: 1.3)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Plano de Treino
            const Text('Plano de Treino',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SmallDarkButton(
                    text: 'Baixar\nplanilha',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                AddButton(onPressed: () {}),
              ],
            ),

            const SizedBox(height: 30),

            // Treinos realizados
            const Text('Treinos realizados',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Botão de adicionar treino
            BorderedButton(text: '+', onPressed: () {}),

            const SizedBox(height: 12),

            // Lista de treinos
            TrainingButton(text: 'Treino 23/04/2025', onPressed: () {}),
            TrainingButton(text: 'Treino 29/04/2025', onPressed: () {}),
            TrainingButton(text: 'Treino 06/05/2025', onPressed: () {}),
            TrainingButton(text: 'Treino 10/05/2025', onPressed: () {}),

            const SizedBox(height: 28),

            // Botões finais
            GradientButton(text: 'Gerar PDF', onPressed: () {}),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {},
                child: const Text(
                  'Fechar Período',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
