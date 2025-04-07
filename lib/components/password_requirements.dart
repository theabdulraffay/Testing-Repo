import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasEightChars = password.length >= 8;
    final bool hasSymbolOrNumber = password.contains(RegExp(r'[0-9]')) ||
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasNoSpaces = !password.contains(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        RequirementItem(
          text: 'Must be at least 8 characters',
          isMet: hasEightChars,
        ),
        RequirementItem(
          text: 'Must have at least one symbol or number',
          isMet: hasSymbolOrNumber,
        ),
        RequirementItem(
          text: 'Can not contain spaces',
          isMet: hasNoSpaces,
        ),
      ],
    );
  }
}

class RequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const RequirementItem({
    super.key,
    required this.text,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check : Icons.close,
            color: isMet ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
