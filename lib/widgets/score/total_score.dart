import 'package:flutter/material.dart';

import 'package:dice_roller/l10n/app_localizations.dart';

class TotalScoreDisplay extends StatelessWidget {
  final int totalScore;
  final AppLocalizations localizations;

  const TotalScoreDisplay({
    super.key,
    required this.totalScore,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.08 * 255).round()),
            blurRadius: 1,
            spreadRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        localizations.scoreScreenTotalScore(totalScore),
        style: theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
