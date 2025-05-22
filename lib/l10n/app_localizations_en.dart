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
  String get diceTypeD4 => 'D4';

  @override
  String get diceTypeD6 => 'D6';

  @override
  String get diceTypeD8 => 'D8';

  @override
  String get diceTypeD10 => 'D10';

  @override
  String get diceTypeD12 => 'D12';

  @override
  String get diceTypeD20 => 'D20';

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

  @override
  String get modalShareFeedbackTitle => 'Share Your Feedback';

  @override
  String get modalRatingQuestion => 'How would you rate your experience\nwith Dice Roller?';

  @override
  String get ratingPoor => 'Poor';

  @override
  String get ratingFair => 'Fair';

  @override
  String get ratingOkay => 'Okay';

  @override
  String get ratingGood => 'Good';

  @override
  String get emailLabel => 'Email *';

  @override
  String get emailHint => 'Enter your Email';

  @override
  String get tellUsMoreLabel => 'Tell us more *';

  @override
  String get tellUsMoreHint => 'What did you like or dislike? Any suggestions for improvement?';

  @override
  String get submitFeedbackButton => 'Submit Feedback';

  @override
  String get submittingFeedbackButton => 'Submitting...';

  @override
  String get validationPleaseEnterEmail => 'Please enter your email';

  @override
  String get validationPleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get validationPleaseTellUsMore => 'Please tell us more';

  @override
  String get feedbackSubmittedSnackbar => 'Thank you for your feedback! It helps us to improve the app.';

  @override
  String get ratingRequiredError => 'Please select a rating';

  @override
  String get feedbackApiError => 'Failed to submit feedback. Please try again later.';

  @override
  String get welcomeScreenTitle => 'Welcome to DiceRoll';

  @override
  String get welcomeScreenSubtitle => 'Your pocket dice simulator';

  @override
  String get welcomeScreenHowToUseTitle => 'How to use the app:';

  @override
  String get welcomeScreenFeature1Title => 'Set number of dices';

  @override
  String get welcomeScreenFeature1Description => 'Want to roll more dice? Set your preferred number in Settings via the gear icon.';

  @override
  String get welcomeScreenFeature2Title => 'Choose dice type';

  @override
  String get welcomeScreenFeature2Description => 'Choose between d6-classic, d4, d6, d8, d10, d12 or d20 dice in Settings by tapping the gear icon.';

  @override
  String get welcomeScreenFeature3Title => 'Shake to roll';

  @override
  String get welcomeScreenFeature3Description => 'Simply shake your phone or tap the roll button to throw your dice.';

  @override
  String get welcomeScreenFeature4Title => 'See rolls results';

  @override
  String get welcomeScreenFeature4Description => 'Check your roll history - view the last 20 results by tapping the results icon on the left.';

  @override
  String get welcomeScreenLetsRollButton => 'Let\'s Roll';
}
