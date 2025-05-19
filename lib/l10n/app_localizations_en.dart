// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get settingsAppearanceBgColor => 'Background Color';

  @override
  String get settingsAppearanceTitle => 'Appearance';

  @override
  String get settingsDiceSettingsTitle => 'Dice Settings';

  @override
  String get settingsNumberOfDices => 'Number of Dices';

  @override
  String settingsDiceXType(int diceNumber) {
    return 'Dice $diceNumber Type';
  }
}
