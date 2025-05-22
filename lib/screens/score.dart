import 'package:flutter/material.dart';

import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/models/roll_history_entry.dart';
import 'package:dice_roller/widgets/score/score_history_list.dart';

class ScoreScreen extends StatelessWidget {
  final List<RollHistoryEntry> rollHistory;

  const ScoreScreen({super.key, required this.rollHistory});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(localizations.scoreScreenTitle),
        backgroundColor: theme.primaryColor,
        scrolledUnderElevation: 0.0,
      ),
      body: ScoreHistoryList(rollHistory: rollHistory),
    );
  }
}
