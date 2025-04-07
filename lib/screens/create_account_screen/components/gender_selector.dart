import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final List<String> genders;
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelector({
    super.key,
    required this.genders,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: genders.map((gender) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: gender != genders.last ? 8.0 : 0,
            ),
            child: GenderOption(
              gender: gender,
              isSelected: selectedGender == gender,
              onSelected: () => onGenderSelected(gender),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final VoidCallback onSelected;

  const GenderOption({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8F1E7) : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          gender,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
