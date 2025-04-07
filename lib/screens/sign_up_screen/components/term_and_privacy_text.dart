import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
          ),
          children: [
            const TextSpan(
              text:
                  'By selecting Agree and continue, I agree to Dynamic Layers ',
            ),
            TextSpan(
              text: 'Terms of Service',
              style: const TextStyle(color: Colors.brown),
              // This would typically have a tap gesture detector
            ),
            const TextSpan(text: ', '),
            TextSpan(
              text: 'Payments Terms of Service',
              style: const TextStyle(color: Colors.brown),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Notification Policy',
              style: const TextStyle(color: Colors.brown),
            ),
            const TextSpan(text: ' and acknowledge the '),
            TextSpan(
              text: 'Privacy Policy',
              style: const TextStyle(color: Colors.brown),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
