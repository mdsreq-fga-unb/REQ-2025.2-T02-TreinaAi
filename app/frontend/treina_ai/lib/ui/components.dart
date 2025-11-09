import 'package:flutter/material.dart';

//==================== COLORS ====================
const Color primaryRed = Color(0xFFE53935);
const Color gradientStart = Color(0xFFFF8A5C);
const Color gradientEnd = Color(0xFFC30000);
const Color backgroundColor = Color(0xFFF5F5F5);

//==================== TEXT STYLES ====================
const TextStyle titleText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const TextStyle studentNameStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const TextStyle inactiveStudentsButtonStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

//==================== INPUT DECORATIONS ====================
InputDecoration searchInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: const Icon(Icons.search, color: Colors.grey),
    suffixIcon: const Icon(Icons.tune, color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
  );
}

InputDecoration defaultInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  );
}

//==================== SIMPLE BORDER BUTTON (Students PAGE "+") ====================
class BorderedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BorderedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryRed,
          side: const BorderSide(color: primaryRed, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//==================== STUDENT CARD ====================
class StudentCard extends StatelessWidget {
  final String name;
  final bool isActive;
  final VoidCallback? onTap;

  const StudentCard({
    super.key,
    required this.name,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? primaryRed : Colors.grey[600],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: studentNameStyle),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

//==================== DARK BUTTON (INACTIVE STUDENTS) ====================
class DarkRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DarkRoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1C2A35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(text, style: inactiveStudentsButtonStyle),
      ),
    );
  }
}

//==================== GradientButton ====================
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
InputDecoration formInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black54, width: 1),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.2),
    ),
  );
}

//============= Periodo - Page Area =================

/// Botão padrão estilizado
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: padding,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// Botão de adicionar (quadrado com o sinal de +)
class AddSquareButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;

  const AddSquareButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFE8E3E3),
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.add, color: iconColor, size: 30),
      ),
    );
  }
}

/// Botão para cada treino realizado
class TrainingButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TrainingButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE67C5B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
