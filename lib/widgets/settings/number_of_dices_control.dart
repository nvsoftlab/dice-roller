import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NumberOfDicesControl extends StatelessWidget {
  final double currentNumberOfDices;
  final ValueChanged<double> onNumberOfDicesChanged;
  final AppLocalizations localizations;

  const NumberOfDicesControl({
    super.key,
    required this.currentNumberOfDices,
    required this.onNumberOfDicesChanged,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              localizations.settingsNumberOfDices,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Spacer(),
            Text(
              '${currentNumberOfDices.toInt()}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: currentNumberOfDices,
          min: 1,
          max: 6,
          divisions: 5,
          onChanged: onNumberOfDicesChanged,
        ),
      ],
    );
  }
}
