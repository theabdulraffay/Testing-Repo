import 'package:flutter/material.dart';

class BirthdayPicker extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const BirthdayPicker({
    super.key,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          onDateSelected(picked);

          controller.text = picked.toUtc().toString();
          // DateFormat('MM/dd/yyyy').format(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.text.isEmpty ? 'MM/DD/YYYY' : controller.text,
              style: TextStyle(
                color: controller.text.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
            const Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }
}
