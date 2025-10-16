import 'package:flutter/material.dart';

//Color Styles
const Color primaryRed = Color(0xFFE53935);
const Color gradientStart = Color(0xFFFF8A5C);
const Color gradientEnd = Color(0xFFC30000);

//Normal Text Styles
const TextStyle titleText = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const TextStyle sectionTitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle inputLabelStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w500,
);

//Input Decoration
InputDecoration defaultInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: const UnderlineInputBorder(),
    labelStyle: TextStyle(color: Colors.grey[700]),
  );
}

//Gender Button
class GenderButton extends StatelessWidget {
  final String gender;
  final bool selected;
  final VoidCallback onTap;

  const GenderButton({
    super.key,
    required this.gender,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(gender),
      selected: selected,
      selectedColor: primaryRed.withOpacity(0.1),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? primaryRed : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: primaryRed),
      onSelected: (_) => onTap(),
    );
  }
}

//Button with Gradient
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
