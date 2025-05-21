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
  String get settingsGeneralTitle => 'General';

  @override
  String get settingsSoundEffects => 'Sound Effects';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsKeepScreenOn => 'Keep Screen On';

  @override
  String get settingsFeedbackTitle => 'Feedback';

  @override
  String get settingsSendFeedback => 'Send Feedback';

  @override
  String get settingsRateThisApp => 'Rate this app';

  @override
  String settingsDiceXType(int diceNumber) {
    return 'Dice $diceNumber Type';
  }

  @override
  String diceScreenYourScoreX(int score) {
    return 'Your Score: $score';
  }

  @override
  String get diceRollButtonText => 'Roll';

  @override
  String get diceTypeD6Classic => 'D6 Classic';

  @override
  String get diceTypeD6 => 'D6';

  @override
  String get diceTypeD10 => 'D10';

  @override
  String get settingsSelectOption => 'Select an option';

  @override
  String get scoreScreenTitle => 'Score History';

  @override
  String get scoreScreenNoRolls => 'No rolls recorded yet.';

  @override
  String scoreScreenTotalScore(Object score) {
    return 'Total: $score';
  }
}
