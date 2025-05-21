import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dice_roller/utils/color_utils.dart';

class DiceScreenHeader extends StatelessWidget {
  final VoidCallback onScorePressed;
  final VoidCallback onSettingsPressed;
  final Color backgroundColor;
  final int currentScore;

  const DiceScreenHeader({
    super.key,
    required this.onScorePressed,
    required this.onSettingsPressed,
    required this.backgroundColor,
    required this.currentScore,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);

    final Color scoreContainerColor = ColorUtils.getLighterColor(
      backgroundColor,
      0.07,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.history, color: Colors.white, size: 30),
              onPressed: onScorePressed,
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white, size: 30),
              onPressed: onSettingsPressed,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: scoreContainerColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.05 * 255).round()),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                localizations.diceScreenYourScoreX(currentScore),
                style: theme.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
