import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/common/switch.dart';
import 'package:dice_roller/widgets/settings/settings_section_layout.dart';
import 'package:dice_roller/constants/shared_preferences_indexes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSection extends StatefulWidget {
  const GeneralSection({super.key});

  @override
  State<GeneralSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  static bool soundEffectsEnabledDefaultValue = true;
  static bool vibrationEnabledDefaultValue = true;
  static bool keepScreenOnEnabledDefaultValue = true;

  bool _soundEffectsEnabled = soundEffectsEnabledDefaultValue;
  bool _vibrationEnabled = vibrationEnabledDefaultValue;
  bool _keepScreenOnEnabled = keepScreenOnEnabledDefaultValue;

  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = _loadSettings();
  }

  Future<void> _loadSettings() async {
    final preferences = await SharedPreferences.getInstance();
    // Ensure the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        _soundEffectsEnabled =
            preferences.getBool(settingsSoundEffectsKey) ??
            soundEffectsEnabledDefaultValue;
        _vibrationEnabled =
            preferences.getBool(settingsVibrationKey) ??
            vibrationEnabledDefaultValue;
        _keepScreenOnEnabled =
            preferences.getBool(settingsKeepScreenOnKey) ??
            keepScreenOnEnabledDefaultValue;
      });
    }
  }

  Future<void> _saveSetting(String key, bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SettingsSectionLayout(
      title: localizations.settingsGeneralTitle,
      // Use FutureBuilder to conditionally display content based on loading state
      content: FutureBuilder(
        future: _initializationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                CustomSwitch(
                  title: localizations.settingsSoundEffects,
                  value: _soundEffectsEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      _soundEffectsEnabled = newValue;
                    });
                    _saveSetting(settingsSoundEffectsKey, newValue);
                  },
                ),
                CustomSwitch(
                  title: localizations.settingsVibration,
                  value: _vibrationEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      _vibrationEnabled = newValue;
                    });
                    _saveSetting(settingsVibrationKey, newValue);
                  },
                ),
                CustomSwitch(
                  title: localizations.settingsKeepScreenOn,
                  value: _keepScreenOnEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      _keepScreenOnEnabled = newValue;
                    });
                    _saveSetting(settingsKeepScreenOnKey, newValue);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
