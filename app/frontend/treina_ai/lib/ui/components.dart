import 'package:flutter/material.dart';



//Color Styles
const Color primaryRed = Color(0xFFE53935);
const Color gradientStart = Color(0xFFFF8A5C);
const Color gradientEnd = Color(0xFFC30000);
const Color backgroundColor = Color(0xFFF5F5F5);

//Normal Text Styles
const TextStyle titleText = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle sectionTitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle inputLabelStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w500,
);

const TextStyle studentNameStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const TextStyle sectionHeaderStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

//Input Decoration
InputDecoration defaultInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: const UnderlineInputBorder(),
    labelStyle: TextStyle(color: Colors.grey[700]),
  );
}

InputDecoration searchInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: const Icon(Icons.search),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
  final double? width;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
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

//Student Card Component
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isActive ? primaryRed : Colors.grey,
          child: Text(
            name.substring(0, 1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          name,
          style: studentNameStyle,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

//Section Header Component
class SectionHeader extends StatelessWidget {
  final String title;
  final int itemCount;

  const SectionHeader({
    super.key,
    required this.title,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: sectionHeaderStyle,
          ),
          Text(
            '($itemCount)',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

}

const TextStyle inactiveStudentsButtonStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  decoration: TextDecoration.underline,
  decorationThickness: 2.0,
  decorationColor: Colors.black,
);