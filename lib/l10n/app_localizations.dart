import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @settingsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreenTitle;

  /// No description provided for @settingsAppearanceBgColor.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get settingsAppearanceBgColor;

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsDiceSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Dice Settings'**
  String get settingsDiceSettingsTitle;

  /// No description provided for @settingsNumberOfDices.
  ///
  /// In en, this message translates to:
  /// **'Number of Dices'**
  String get settingsNumberOfDices;

  /// No description provided for @settingsGeneralTitle.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneralTitle;

  /// No description provided for @settingsSoundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get settingsSoundEffects;

  /// No description provided for @settingsVibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsVibration;

  /// No description provided for @settingsKeepScreenOn.
  ///
  /// In en, this message translates to:
  /// **'Keep Screen On'**
  String get settingsKeepScreenOn;

  /// No description provided for @settingsFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get settingsFeedbackTitle;

  /// No description provided for @settingsSendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get settingsSendFeedback;

  /// No description provided for @settingsRateThisApp.
  ///
  /// In en, this message translates to:
  /// **'Rate this app'**
  String get settingsRateThisApp;

  /// Label for individual dice type selection, e.g., 'Dice 1 Type'
  ///
  /// In en, this message translates to:
  /// **'Dice {diceNumber} Type'**
  String settingsDiceXType(int diceNumber);

  /// 'Your Score: 5'
  ///
  /// In en, this message translates to:
  /// **'Your Score: {score}'**
  String diceScreenYourScoreX(int score);

  /// No description provided for @diceRollButtonText.
  ///
  /// In en, this message translates to:
  /// **'Roll'**
  String get diceRollButtonText;

  /// No description provided for @diceTypeD6Classic.
  ///
  /// In en, this message translates to:
  /// **'D6 Classic'**
  String get diceTypeD6Classic;

  /// No description provided for @diceTypeD4.
  ///
  /// In en, this message translates to:
  /// **'D4'**
  String get diceTypeD4;

  /// No description provided for @diceTypeD6.
  ///
  /// In en, this message translates to:
  /// **'D6'**
  String get diceTypeD6;

  /// No description provided for @diceTypeD8.
  ///
  /// In en, this message translates to:
  /// **'D8'**
  String get diceTypeD8;

  /// No description provided for @diceTypeD10.
  ///
  /// In en, this message translates to:
  /// **'D10'**
  String get diceTypeD10;

  /// No description provided for @diceTypeD12.
  ///
  /// In en, this message translates to:
  /// **'D12'**
  String get diceTypeD12;

  /// No description provided for @diceTypeD20.
  ///
  /// In en, this message translates to:
  /// **'D20'**
  String get diceTypeD20;

  /// No description provided for @settingsSelectOption.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get settingsSelectOption;

  /// No description provided for @scoreScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Score History'**
  String get scoreScreenTitle;

  /// No description provided for @scoreScreenNoRolls.
  ///
  /// In en, this message translates to:
  /// **'No rolls recorded yet.'**
  String get scoreScreenNoRolls;

  /// No description provided for @scoreScreenTotalScore.
  ///
  /// In en, this message translates to:
  /// **'Total: {score}'**
  String scoreScreenTotalScore(Object score);

  /// No description provided for @modalShareFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Your Feedback'**
  String get modalShareFeedbackTitle;

  /// No description provided for @modalRatingQuestion.
  ///
  /// In en, this message translates to:
  /// **'How would you rate your experience\nwith Dice Roller?'**
  String get modalRatingQuestion;

  /// No description provided for @ratingPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get ratingPoor;

  /// No description provided for @ratingFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get ratingFair;

  /// No description provided for @ratingOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get ratingOkay;

  /// No description provided for @ratingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get ratingGood;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get emailHint;

  /// No description provided for @tellUsMoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Tell us more *'**
  String get tellUsMoreLabel;

  /// No description provided for @tellUsMoreHint.
  ///
  /// In en, this message translates to:
  /// **'What did you like or dislike? Any suggestions for improvement?'**
  String get tellUsMoreHint;

  /// No description provided for @submitFeedbackButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get submitFeedbackButton;

  /// No description provided for @submittingFeedbackButton.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submittingFeedbackButton;

  /// No description provided for @validationPleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get validationPleaseEnterEmail;

  /// No description provided for @validationPleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validationPleaseEnterValidEmail;

  /// No description provided for @validationPleaseTellUsMore.
  ///
  /// In en, this message translates to:
  /// **'Please tell us more'**
  String get validationPleaseTellUsMore;

  /// No description provided for @feedbackSubmittedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback! It helps us to improve the app.'**
  String get feedbackSubmittedSnackbar;

  /// No description provided for @ratingRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Please select a rating'**
  String get ratingRequiredError;

  /// No description provided for @feedbackApiError.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit feedback. Please try again later.'**
  String get feedbackApiError;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
