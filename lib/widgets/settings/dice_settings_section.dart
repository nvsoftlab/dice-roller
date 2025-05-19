import 'package:dice_roller/constants/shared_preferences_indexes.dart';
import 'package:dice_roller/models/dice_type.dart';
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
  late List<DiceType?> _diceTypes;
  bool _isLoading = true;

  DiceType get _defaultDiceType {
    return DiceType.d6Classic;
  }

  @override
  void initState() {
    super.initState();
    _numberOfDices = _initialNumberOfDicesDefault;
    _diceTypes = List<DiceType?>.generate(
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
    List<DiceType?> finalDiceTypes;

    if (loadedPersistedTypes != null &&
        loadedPersistedTypes.length == currentDiceCount) {
      finalDiceTypes = loadedPersistedTypes
          .map<DiceType?>((typeString) {
            try {
              return DiceType.fromString(typeString);
            } catch (_) {
              return _defaultDiceType; // Fallback for invalid stored string
            }
          })
          .toList(growable: true);
    } else {
      finalDiceTypes = List<DiceType?>.generate(
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

    // This logic correctly re-saves if the loaded data was inconsistent or absent.
    if (loadedPersistedTypes == null ||
        (loadedPersistedTypes.length != currentDiceCount)) {
      await _saveSettings();
    }
  }

  Future<void> _saveSettings() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(numberOfDicesKey, _numberOfDices);
    List<String> typesToSave =
        _diceTypes
            .map((type) => type?.stringValue ?? _defaultDiceType.stringValue)
            .toList();
    await preferences.setStringList(diceTypesKey, typesToSave);
  }

  void _handleNumberOfDicesChanged(double value) {
    setState(() {
      int oldDiceCount = _numberOfDices.toInt();
      _numberOfDices = value;
      int newCount = value.toInt();

      if (newCount > oldDiceCount) {
        List<DiceType?> itemsToAdd = List<DiceType?>.generate(
          newCount - oldDiceCount,
          (_) => _defaultDiceType,
          growable: false,
        );
        _diceTypes.addAll(itemsToAdd);
      } else if (newCount < oldDiceCount) {
        _diceTypes.removeRange(newCount, oldDiceCount);
      }

      // Safeguard: Ensure _diceTypes list is consistent with newCount.
      if (_diceTypes.length != newCount) {
        _diceTypes = List<DiceType?>.generate(
          newCount,
          (_) => _defaultDiceType,
          growable: true,
        );
      }
    });
    _saveSettings();
  }

  void _handleDiceTypeChanged(int index, DiceType? newValue) {
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
}
