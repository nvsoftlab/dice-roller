import 'package:dice_roller/widgets/common/dropdown.dart';
import 'package:flutter/material.dart';

class DiceTypeRow extends StatelessWidget {
  final String title;
  final String? currentValue;
  final ValueChanged<String?> onChanged;

  const DiceTypeRow({
    super.key,
    required this.title,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: Theme.of(context).textTheme.labelMedium),
          ),
          Expanded(
            flex: 3,
            child: DiceTypeDropdown(
              // Your existing dropdown
              currentValue: currentValue,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
