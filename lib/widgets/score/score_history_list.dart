import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/models/roll_history_entry.dart';
import 'package:dice_roller/widgets/score/mini_dice_widget.dart';
import 'package:dice_roller/widgets/score/score_section_layout.dart';
import 'package:dice_roller/widgets/score/total_score.dart';

class ScoreHistoryList extends StatelessWidget {
  final List<RollHistoryEntry> rollHistory;

  const ScoreHistoryList({super.key, required this.rollHistory});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (rollHistory.isEmpty) {
      return Center(
        child: Text(
          localizations.scoreScreenNoRolls,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: rollHistory.length,
      itemBuilder: (context, index) {
        final entry = rollHistory[index];
        final formattedDate = DateFormat.yMMMd(
          localizations.localeName,
        ).add_jm().format(entry.timestamp);

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ScoreSectionLayout(
            title: formattedDate,
            totalScoreWidget: TotalScoreDisplay(
              totalScore: entry.totalScore,
              localizations: localizations,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (entry.individualRolls.isNotEmpty)
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: entry.individualRolls.length,
                      itemBuilder: (context, dieIndex) {
                        final dieRoll = entry.individualRolls[dieIndex];
                        return Container(
                          width: 80,
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${dieRoll.type.getDisplayName(localizations)}:",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                MiniDiceWidget(
                                  type: dieRoll.type,
                                  value: dieRoll.value,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
