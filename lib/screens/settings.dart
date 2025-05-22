import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/appearance_section.dart';
import 'package:dice_roller/widgets/settings/dice_settings_section.dart';
import 'package:dice_roller/widgets/settings/feedback_section.dart';
import 'package:dice_roller/widgets/settings/general_section.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settingsScreenTitle),
        scrolledUnderElevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: ListView(
          children: [
            AppearanceSection(),
            SizedBox(height: 24),
            DiceSettingsSection(),
            SizedBox(height: 24),
            GeneralSection(),
            SizedBox(height: 24),
            FeedbackSection(),
          ],
        ),
      ),
    );
  }
}
