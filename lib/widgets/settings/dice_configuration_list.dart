import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/models/dice_type.dart';
import 'package:dice_roller/widgets/settings/dice_type_row.dart';
import 'package:flutter/material.dart';

class DiceConfigurationList extends StatelessWidget {
  final int numberOfDices;
  final List<DiceType?> diceTypes;
  final AppLocalizations localizations;
  final void Function(int index, DiceType? newType) onDiceTypeChanged;

  const DiceConfigurationList({
    super.key,
    required this.numberOfDices,
    required this.diceTypes,
    required this.localizations,
    required this.onDiceTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(numberOfDices, (index) {
        final DiceType? currentTypeValue =
            (index < diceTypes.length) ? diceTypes[index] : null;

        return DiceTypeRow(
          title: localizations.settingsDiceXType(index + 1),
          currentValue: currentTypeValue,
          onChanged: (DiceType? newValue) {
            onDiceTypeChanged(index, newValue);
          },
        );
      }),
    );
  }
}
