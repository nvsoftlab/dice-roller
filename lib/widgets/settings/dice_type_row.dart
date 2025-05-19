import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/models/dice_type.dart';
import 'package:dice_roller/widgets/common/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:dice_roller/models/option.dart';
import 'package:dice_roller/l10n/app_localizations.dart';

class DiceTypeRow extends StatelessWidget {
  final String title;
  final DiceType? currentValue;
  final ValueChanged<DiceType?> onChanged;

  const DiceTypeRow({
    super.key,
    required this.title,
    required this.currentValue,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final List<Option<DiceType>> diceOptions =
        kDiceTypeOptions.map((stringValue) {
          final diceType = DiceType.fromString(stringValue);

          return Option<DiceType>(
            label: diceType.getDisplayName(localizations),
            value: diceType,
          );
        }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: Theme.of(context).textTheme.labelMedium),
          ),
          Expanded(
            flex: 3,
            child: CustomDropdown<DiceType>(
              currentValue: currentValue,
              onChanged: onChanged,
              options: diceOptions,
            ),
          ),
        ],
      ),
    );
  }
}
