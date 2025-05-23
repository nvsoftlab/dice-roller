// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get settingsScreenTitle => 'Ustawienia';

  @override
  String get settingsAppearanceBgColor => 'Kolor tła';

  @override
  String get settingsAppearanceTitle => 'Wygląd';

  @override
  String get settingsDiceSettingsTitle => 'Ustawienia kości';

  @override
  String get settingsNumberOfDices => 'Liczba kości';

  @override
  String get settingsGeneralTitle => 'Ogólne';

  @override
  String get settingsSoundEffects => 'Efekty dźwiękowe';

  @override
  String get settingsVibration => 'Wibracje';

  @override
  String get settingsKeepScreenOn => 'Nie wygaszaj ekranu';

  @override
  String get settingsFeedbackTitle => 'Opinia';

  @override
  String get settingsSendFeedback => 'Wyślij opinię';

  @override
  String get settingsRateThisApp => 'Oceń tę aplikację';

  @override
  String settingsDiceXType(int diceNumber) {
    return 'Typ kości $diceNumber';
  }

  @override
  String diceScreenYourScoreX(int score) {
    return 'Twój wynik: $score';
  }

  @override
  String get diceRollButtonText => 'Rzuć';

  @override
  String get diceTypeD6Classic => 'K6 Klasyczna';

  @override
  String get diceTypeD4 => 'K4';

  @override
  String get diceTypeD6 => 'K6';

  @override
  String get diceTypeD8 => 'K8';

  @override
  String get diceTypeD10 => 'K10';

  @override
  String get diceTypeD12 => 'K12';

  @override
  String get diceTypeD20 => 'K20';

  @override
  String get settingsSelectOption => 'Wybierz opcję';

  @override
  String get scoreScreenTitle => 'Historia wyników';

  @override
  String get scoreScreenNoRolls => 'Brak zarejestrowanych rzutów.';

  @override
  String scoreScreenTotalScore(Object score) {
    return 'Suma: $score';
  }

  @override
  String get modalShareFeedbackTitle => 'Podziel się swoją opinią';

  @override
  String get modalRatingQuestion => 'Jak oceniasz swoje doświadczenie\nz aplikacją Dice Roller?';

  @override
  String get ratingPoor => 'Słabo';

  @override
  String get ratingFair => 'Umiarkowanie';

  @override
  String get ratingOkay => 'W porządku';

  @override
  String get ratingGood => 'Dobrze';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get emailHint => 'Wpisz swój adres e-mail';

  @override
  String get tellUsMoreLabel => 'Powiedz nam więcej *';

  @override
  String get tellUsMoreHint => 'Co Ci się podobało lub nie? Jakieś sugestie dotyczące ulepszeń?';

  @override
  String get submitFeedbackButton => 'Wyślij opinię';

  @override
  String get submittingFeedbackButton => 'Wysyłanie...';

  @override
  String get validationPleaseEnterEmail => 'Proszę podać adres e-mail';

  @override
  String get validationPleaseEnterValidEmail => 'Proszę podać prawidłowy adres e-mail';

  @override
  String get validationPleaseTellUsMore => 'Proszę opisać więcej';

  @override
  String get feedbackSubmittedSnackbar => 'Dziękujemy za Twoją opinię! Pomaga nam to ulepszać aplikację.';

  @override
  String get ratingRequiredError => 'Proszę wybrać ocenę';

  @override
  String get feedbackApiError => 'Nie udało się wysłać opinii. Spróbuj ponownie później.';

  @override
  String get welcomeScreenTitle => 'Witaj w DiceRoll';

  @override
  String get welcomeScreenSubtitle => 'Twój kieszonkowy symulator kości';

  @override
  String get welcomeScreenHowToUseTitle => 'Jak korzystać z aplikacji:';

  @override
  String get welcomeScreenFeature1Title => 'Ustaw liczbę kości';

  @override
  String get welcomeScreenFeature1Description => 'Chcesz rzucić więcej kości? Ustaw preferowaną liczbę w Ustawieniach za pomocą ikony zębatki.';

  @override
  String get welcomeScreenFeature2Title => 'Wybierz typ kości';

  @override
  String get welcomeScreenFeature2Description => 'Wybierz kości d6-klasyczne, d4, d6, d8, d10, d12 lub d20 w Ustawieniach, dotykając ikony zębatki.';

  @override
  String get welcomeScreenFeature3Title => 'Potrząśnij, aby rzucić';

  @override
  String get welcomeScreenFeature3Description => 'Po prostu potrząśnij telefonem lub dotknij przycisku rzutu, aby rzucić kości.';

  @override
  String get welcomeScreenFeature4Title => 'Zobacz wyniki rzutów';

  @override
  String get welcomeScreenFeature4Description => 'Sprawdź historię swoich rzutów – przeglądaj 20 ostatnich wyników, dotykając ikony wyników po lewej stronie.';

  @override
  String get welcomeScreenLetsRollButton => 'Zaczynajmy';

  @override
  String get settingsTermsOfUse => 'Warunki użytkowania';

  @override
  String get settingsPrivacyPolicy => 'Polityka prywatności';
}
