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
  static const double _initialNumberOfDicesDefault = 1;

  late double _numberOfDices;
  late List<String?> _diceTypes;
  bool _isLoading = true;

  String get _defaultDiceType {
    if (kDiceTypeOptions.isNotEmpty && kDiceTypeOptions[0].isNotEmpty) {
      return kDiceTypeOptions[0];
    }

    return kDiceTypeOptions[0];
  }

  @override
  void initState() {
    super.initState();
    _numberOfDices = _initialNumberOfDicesDefault;
    _diceTypes = List<String?>.generate(
      _numberOfDices.toInt(),
      (_) => _defaultDiceType,
      growable: true,
    );
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final preferences = await SharedPreferences.getInstance();

    double loadedNumberOfDices =
        preferences.getDouble(numberOfDicesKey) ?? _initialNumberOfDicesDefault;

    List<String>? loadedPersistedTypes = preferences.getStringList(
      diceTypesKey,
    );
    int currentDiceCount = loadedNumberOfDices.toInt();
    List<String?> finalDiceTypes;

    if (loadedPersistedTypes != null &&
        loadedPersistedTypes.length == currentDiceCount) {
      finalDiceTypes = List<String?>.from(loadedPersistedTypes, growable: true);
    } else {
      finalDiceTypes = List<String?>.generate(
        currentDiceCount,
        (_) => _defaultDiceType,
        growable: true,
      );
    }

    if (!mounted) return;

    setState(() {
      _numberOfDices = loadedNumberOfDices;
      _diceTypes = finalDiceTypes;
      _isLoading = false;
    });

    if (loadedPersistedTypes == null ||
        (loadedPersistedTypes.length != currentDiceCount)) {
      await _saveSettings();
    }
  }

  Future<void> _saveSettings() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(numberOfDicesKey, _numberOfDices);
    List<String> typesToSave =
        _diceTypes.map((type) => type ?? _defaultDiceType).toList();
    await preferences.setStringList(diceTypesKey, typesToSave);
  }

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

      // Safeguard: Ensure _diceTypes list is consistent with newCount.
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

  void _handleDiceTypeChanged(int index, String? newValue) {
    if (index >= 0 && index < _diceTypes.length) {
      setState(() {
        _diceTypes[index] = newValue;
      });
      _saveSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SettingsSectionLayout(
        title: AppLocalizations.of(context)!.settingsDiceSettingsTitle,
        content: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

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

  // This widget for a switch row is preserved as it might be used later.
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
