// File: dice_settings_section.dart (Your main file)
import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/constants/shared_preferences_indexes.dart';
import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/dice_configuration_list.dart';
import 'package:dice_roller/widgets/settings/number_of_dices_control.dart';
import 'package:dice_roller/widgets/settings/settings_section_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiceSettingsSection extends StatefulWidget {
  const DiceSettingsSection({super.key});

  @override
  State<DiceSettingsSection> createState() => _DiceSettingsSectionState();
}

class _DiceSettingsSectionState extends State<DiceSettingsSection> {
  double _numberOfDices = 4.0;
  late List<String?> _diceTypes;

  String get _defaultDiceType {
    if (kDiceTypeOptions.isNotEmpty) {
      final firstOption = kDiceTypeOptions[0];
      if (firstOption.isNotEmpty) {
        return firstOption;
      }
    }
    return 'D6';
  }

  @override
  void initState() {
    super.initState();
    _diceTypes = List<String?>.generate(
      _numberOfDices.toInt(),
      (_) => _defaultDiceType,
      growable: true,
    );
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _numberOfDices = prefs.getDouble(numberOfDicesKey) ?? _numberOfDices;
      List<String>? loadedTypes = prefs.getStringList(diceTypesKey);
      int currentDiceCount = _numberOfDices.toInt();

      if (loadedTypes != null && loadedTypes.length == currentDiceCount) {
        _diceTypes = List<String?>.from(loadedTypes, growable: true);
      } else {
        _diceTypes = List<String?>.generate(
          currentDiceCount,
          (_) => _defaultDiceType,
          growable: true,
        );
        if (loadedTypes == null || (loadedTypes.length != currentDiceCount)) {
          _saveSettings();
        }
      }
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(numberOfDicesKey, _numberOfDices);
    List<String> typesToSave =
        _diceTypes.map((type) => type ?? _defaultDiceType).toList();
    await prefs.setStringList(diceTypesKey, typesToSave);
  }

  // Callback for NumberOfDicesControlWidget
  void _handleNumberOfDicesChanged(double value) {
    setState(() {
      int oldDiceCount = _numberOfDices.toInt();
      _numberOfDices = value;
      int newCount = value.toInt();

      if (newCount > oldDiceCount) {
        _diceTypes.addAll(
          List.generate(newCount - oldDiceCount, (_) => _defaultDiceType),
        );
      } else if (newCount < oldDiceCount) {
        _diceTypes = _diceTypes.sublist(0, newCount);
      }
      // Ensure consistency after adjustment (though above logic should handle it)
      if (_diceTypes.length != newCount) {
        _diceTypes = List<String?>.generate(
          newCount,
          (_) => _defaultDiceType,
          growable: true,
        );
      }
    });
    _saveSettings();
  }

  // Callback for DiceConfigurationListWidget
  void _handleDiceTypeChanged(int index, String? newValue) {
    // Ensure index is within bounds before updating
    if (index >= 0 && index < _diceTypes.length) {
      setState(() {
        _diceTypes[index] = newValue;
      });
      _saveSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SettingsSectionLayout(
      title: localizations.settingsDiceSettingsTitle,
      content: Column(
        children: [
          NumberOfDicesControl(
            currentNumberOfDices: _numberOfDices,
            onNumberOfDicesChanged: _handleNumberOfDicesChanged,
            localizations: localizations,
          ),
          const SizedBox(height: 16),
          DiceConfigurationList(
            numberOfDices: _numberOfDices.toInt(),
            diceTypes: _diceTypes,
            localizations: localizations,
            onDiceTypeChanged: _handleDiceTypeChanged,
          ),
        ],
      ),
    );
  }

  // will be used later
  Widget _buildSwitchRow(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.bodyLarge!),
              SizedBox(
                height: 24,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Theme.of(
                    context,
                  ).switchTheme.thumbColor?.resolve({MaterialState.selected}),
                  activeTrackColor: Theme.of(
                    context,
                  ).switchTheme.trackColor?.resolve({MaterialState.selected}),
                  inactiveThumbColor: Theme.of(
                    context,
                  ).switchTheme.thumbColor?.resolve({}),
                  inactiveTrackColor: Theme.of(
                    context,
                  ).switchTheme.trackColor?.resolve({}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
