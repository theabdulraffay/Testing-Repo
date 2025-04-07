import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String strength;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    Color indicatorColor;
    String strengthText;

    switch (strength) {
      case 'strong':
        indicatorColor = Colors.green;
        strengthText = 'strong';
        break;
      case 'medium':
        indicatorColor = Colors.orange;
        strengthText = 'medium';
        break;
      default:
        indicatorColor = Colors.red;
        strengthText = 'weak';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Icon(strength == 'weak' ? Icons.error : Icons.info_outline,
              color: indicatorColor, size: 20),
          const SizedBox(width: 4),
          Text(
            'Password strength: $strengthText',
            style: GoogleFonts.poppins(
              color: indicatorColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
