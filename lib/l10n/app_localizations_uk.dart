// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get settingsScreenTitle => 'Налаштування';

  @override
  String get settingsAppearanceBgColor => 'Колір тла';

  @override
  String get settingsAppearanceTitle => 'Вигляд';

  @override
  String get settingsDiceSettingsTitle => 'Налаштування кубиків';

  @override
  String get settingsNumberOfDices => 'Кількість кубиків';

  @override
  String get settingsGeneralTitle => 'Загальні';

  @override
  String get settingsSoundEffects => 'Звукові ефекти';

  @override
  String get settingsVibration => 'Вібрація';

  @override
  String get settingsKeepScreenOn => 'Не вимикати екран';

  @override
  String get settingsFeedbackTitle => 'Відгук';

  @override
  String get settingsSendFeedback => 'Надіслати відгук';

  @override
  String get settingsRateThisApp => 'Оцінити цю програму';

  @override
  String settingsDiceXType(int diceNumber) {
    return 'Тип кубика $diceNumber';
  }

  @override
  String diceScreenYourScoreX(int score) {
    return 'Ваш результат: $score';
  }

  @override
  String get diceRollButtonText => 'Кинути';

  @override
  String get diceTypeD6Classic => 'D6 Класичний';

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
  String get settingsSelectOption => 'Виберіть опцію';

  @override
  String get scoreScreenTitle => 'Історія результатів';

  @override
  String get scoreScreenNoRolls => 'Жодного кидка ще не записано.';

  @override
  String scoreScreenTotalScore(Object score) {
    return 'Всього: $score';
  }

  @override
  String get modalShareFeedbackTitle => 'Поділіться своїм відгуком';

  @override
  String get modalRatingQuestion => 'Як би ви оцінили свій досвід\nвикористання Dice Roller?';

  @override
  String get ratingPoor => 'Погано';

  @override
  String get ratingFair => 'Задовільно';

  @override
  String get ratingOkay => 'Нормально';

  @override
  String get ratingGood => 'Добре';

  @override
  String get emailLabel => 'Електронна пошта *';

  @override
  String get emailHint => 'Введіть свою електронну пошту';

  @override
  String get tellUsMoreLabel => 'Розкажіть нам більше *';

  @override
  String get tellUsMoreHint => 'Що вам сподобалось чи не сподобалось? Є пропозиції щодо покращення?';

  @override
  String get submitFeedbackButton => 'Надіслати відгук';

  @override
  String get submittingFeedbackButton => 'Відправлення...';

  @override
  String get validationPleaseEnterEmail => 'Будь ласка, введіть вашу електронну пошту';

  @override
  String get validationPleaseEnterValidEmail => 'Будь ласка, введіть дійсну електронну пошту';

  @override
  String get validationPleaseTellUsMore => 'Будь ласка, розкажіть більше';

  @override
  String get feedbackSubmittedSnackbar => 'Дякуємо за ваш відгук! Це допомагає нам покращувати додаток.';

  @override
  String get ratingRequiredError => 'Будь ласка, виберіть оцінку';

  @override
  String get feedbackApiError => 'Не вдалося надіслати відгук. Будь ласка, спробуйте пізніше.';

  @override
  String get welcomeScreenTitle => 'Ласкаво просимо до DiceRoll';

  @override
  String get welcomeScreenSubtitle => 'Ваш кишеньковий симулятор кубиків';

  @override
  String get welcomeScreenHowToUseTitle => 'Як користуватися програмою:';

  @override
  String get welcomeScreenFeature1Title => 'Встановити кількість кубиків';

  @override
  String get welcomeScreenFeature1Description => 'Хочете кидати більше кубиків? Встановіть бажану кількість у Налаштуваннях за допомогою значка шестерні.';

  @override
  String get welcomeScreenFeature2Title => 'Вибрати тип кубика';

  @override
  String get welcomeScreenFeature2Description => 'Виберіть між класичними кубиками d6, d4, d6, d8, d10, d12 або d20 у Налаштуваннях, натиснувши на значок шестерні.';

  @override
  String get welcomeScreenFeature3Title => 'Струсіть, щоб кинути';

  @override
  String get welcomeScreenFeature3Description => 'Просто струсіть телефон або натисніть кнопку кидка, щоб кинути кубики.';

  @override
  String get welcomeScreenFeature4Title => 'Переглянути результати кидків';

  @override
  String get welcomeScreenFeature4Description => 'Перевірте історію своїх кидків – перегляньте останні 20 результатів, натиснувши на значок результатів ліворуч.';

  @override
  String get welcomeScreenLetsRollButton => 'Почнімо';

  @override
  String get settingsTermsOfUse => 'Умови використання';

  @override
  String get settingsPrivacyPolicy => 'Політика конфіденційності';
}
