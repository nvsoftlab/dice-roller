import 'package:dice_roller/l10n/app_localizations.dart';

enum DiceType {
  d6Classic,
  d6,
  d10;

  int get maxValue {
    switch (this) {
      case DiceType.d6Classic:
      case DiceType.d6:
        return 6;
      case DiceType.d10:
        return 10;
    }
  }

  String get stringValue {
    switch (this) {
      case DiceType.d6Classic:
        return 'D6Classic';
      case DiceType.d6:
        return 'D6';
      case DiceType.d10:
        return 'D10';
    }
  }

  static DiceType fromString(String value) {
    for (var type in DiceType.values) {
      if (type.stringValue == value) {
        return type;
      }
    }
    throw ArgumentError(
      'Unknown DiceType string: $value. Ensure it is one of ${DiceType.values.map((t) => t.stringValue).join(', ')}',
    );
  }

  String getDisplayName(AppLocalizations localizations) {
    switch (this) {
      case DiceType.d6Classic:
        return localizations.diceTypeD6Classic;
      case DiceType.d6:
        return localizations.diceTypeD6;
      case DiceType.d10:
        return localizations.diceTypeD10;
    }
  }
}
