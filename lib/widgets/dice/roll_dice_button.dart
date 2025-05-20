import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/utils/color_utils.dart';
import 'package:flutter/material.dart';

class RollDiceButton extends StatelessWidget {
  final VoidCallback onRoll;
  final Color backgroundColor; // This is the screen's background color

  const RollDiceButton({
    super.key,
    required this.onRoll,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);

    final Color buttonActualBackgroundColor = ColorUtils.getLighterColor(
      backgroundColor,
      0.08,
    );
    final Color contentColor = ColorUtils.getTextColorForBackground(
      buttonActualBackgroundColor,
    );

    return ElevatedButton.icon(
      icon: Icon(Icons.rocket_launch, size: 24, color: Colors.white),
      label: Text(
        localizations.diceRollButtonText,
        style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
      ),
      onPressed: onRoll,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonActualBackgroundColor,
        foregroundColor: contentColor,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white, width: 1.5),
        ),
        elevation: 3,
        shadowColor: contentColor.withAlpha((0.2 * 255).round()),
      ),
    );
  }
}
