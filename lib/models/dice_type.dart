import 'package:dice_roller/l10n/app_localizations.dart';

enum DiceType {
  d6Classic,
  d4,
  d6,
  d8,
  d10,
  d12,
  d20;

  int get maxValue {
    switch (this) {
      case DiceType.d6Classic:
      case DiceType.d6:
        return 6;
      case DiceType.d4:
        return 4;
      case DiceType.d8:
        return 8;
      case DiceType.d10:
        return 10;
      case DiceType.d12:
        return 12;
      case DiceType.d20:
        return 20;
    }
  }

  String get stringValue {
    switch (this) {
      case DiceType.d6Classic:
        return 'D6Classic';
      case DiceType.d4:
        return 'D4';
      case DiceType.d6:
        return 'D6';
      case DiceType.d8:
        return 'D8';
      case DiceType.d10:
        return 'D10';
      case DiceType.d12:
        return 'D12';
      case DiceType.d20:
        return 'D20';
    }
  }

  static DiceType fromString(String value) {
    for (var type in DiceType.values) {
      if (type.stringValue == value) {
        return type;
      }
    }

    // returning fallback value if DiceType not found
    return DiceType.d6Classic;
  }

  String getDisplayName(AppLocalizations localizations) {
    switch (this) {
      case DiceType.d6Classic:
        return localizations.diceTypeD6Classic;
      case DiceType.d4:
        return localizations.diceTypeD4;
      case DiceType.d6:
        return localizations.diceTypeD6;
      case DiceType.d8:
        return localizations.diceTypeD8;
      case DiceType.d10:
        return localizations.diceTypeD10;
      case DiceType.d12:
        return localizations.diceTypeD12;
      case DiceType.d20:
        return localizations.diceTypeD20;
    }
  }

  // Method to convert DiceType to a JSON-compatible string (its name)
  String toJson() => stringValue;

  // Factory constructor to create DiceType from a JSON string (its name)
  static DiceType fromJson(String jsonName) => DiceType.fromString(jsonName);
}
