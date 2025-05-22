import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/feedback_modal.dart';
import 'package:dice_roller/widgets/settings/settings_section_layout.dart';
import 'package:flutter/material.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SettingsSectionLayout(
      title: localizations.settingsFeedbackTitle,
      content: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.email, color: theme.primaryColorDark),
              label: Text(
                localizations.settingsSendFeedback,
                style: TextStyle(
                  color: theme.primaryColorDark,
                  fontSize: theme.textTheme.labelLarge!.fontSize,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return const FeedbackModal();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: theme.primaryColorDark, width: 1),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Text(
              localizations.settingsRateThisApp,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(Icons.star, color: Colors.amber, size: 32.0),
                // TODO: to add logic later for rating directly on this screen
                onPressed: () {},
              );
            }),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text('Dice App: V1.0.0', style: theme.textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}
