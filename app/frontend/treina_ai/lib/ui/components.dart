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

//==================== GRADIENT BUTTON ====================
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

//==================== SQUARE ACTION BUTTONS (PeriodoPage) ====================
class SquareActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const SquareActionButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

class AddSquareButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddSquareButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        onPressed: onPressed,
        child: const Icon(Icons.add, color: Colors.black, size: 34),
      ),
    );
  }
}
//==================== ADD EXERCISE BUTTON (TrainingPage "+") ====================
class AddExerciseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddExerciseButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: gradientStart, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: const Text(
          "+",
          style: TextStyle(
            color: gradientStart,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
