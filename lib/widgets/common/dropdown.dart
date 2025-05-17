import 'package:dice_roller/constants/settings.dart'; // Assuming kDiceTypeOptions is here
import 'package:flutter/material.dart';

class DiceTypeDropdown extends StatelessWidget {
  const DiceTypeDropdown({
    super.key,
    required this.currentValue,
    required this.onChanged,
  });

  final String? currentValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF1F4F8), // User's chosen fill color
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          // 1. Set border with color #e0e3e7 and 2. border radius 8
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFFE0E3E7), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFFE0E3E7), width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFFE0E3E7), width: 1.0),
          ),
        ),
        value: currentValue,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF14181B),
        ),
        elevation: 2,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.black87,
        ), // Style for the selected item in the button
        dropdownColor: Colors.white, // Background color of the dropdown menu
        // menuOffset: Offset.zero, // Removed as it's not available in your Flutter version
        onChanged: onChanged,
        items:
            kDiceTypeOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style:
                      Theme.of(
                        context,
                      ).textTheme.labelMedium, // Style for items in the list
                ),
              );
            }).toList(),
      ),
    );
  }
}
