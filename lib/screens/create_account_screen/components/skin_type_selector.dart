import 'package:flutter/material.dart';

class SkinTypeSelector extends StatelessWidget {
  final List<String> skinTypes;
  final String? selectedSkinType;
  final Function(String) onSkinTypeSelected;

  const SkinTypeSelector({
    super.key,
    required this.skinTypes,
    required this.selectedSkinType,
    required this.onSkinTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: skinTypes.map((skinType) {
        return SelectableChip(
          label: skinType,
          isSelected: selectedSkinType == skinType,
          onSelected: () => onSkinTypeSelected(skinType),
        );
      }).toList(),
    );
  }
}

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEEEEE) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.grey.shade400 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
