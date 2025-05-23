import 'package:dice_roller/constants/shared_preferences_indexes.dart';
import 'package:dice_roller/screens/welcome.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dice_roller/screens/dice.dart';
import 'package:dice_roller/l10n/app_localizations.dart';

final materialTheme = ThemeData(
  primaryColor: Color(0xFFF1F4F8),
  brightness: Brightness.light,
  primaryColorDark: Colors.deepPurpleAccent,
  primaryColorLight: Color(0xFFBCA8FF),
  scaffoldBackgroundColor: const Color(0xFFF1F4F8),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    labelLarge: TextStyle(fontSize: 16, color: Colors.black54),
    labelMedium: TextStyle(
      color: Color(0xFF14181B),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: Colors.deepPurpleAccent,
    inactiveTrackColor: Color(0xFFBCA8FF),
    thumbColor: Colors.deepPurpleAccent,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return Colors.deepPurpleAccent;
      }
      return Colors.grey;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFBCA8FF);
      }
      final greyBase = Colors.grey;
      return Color.fromARGB(
        (0.5 * 255).round(),
        greyBase.red,
        greyBase.green,
        greyBase.blue,
      );
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      return Colors.transparent;
    }),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xFFF1F4F8),
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF14181B)),
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  ),
);

const List<DeviceOrientation> deviceOrientations = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];

void main() async {
  // Ensure that the Flutter framework is initialized.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen until you manually remove it.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Perform any asynchronous initialization tasks here.
  // For example, load user data, fetch config, etc.
  await Future.delayed(const Duration(seconds: 3)); // Simulate a delay

  // Once your app is ready, remove the splash screen.
  FlutterNativeSplash.remove();

  await SystemChrome.setPreferredOrientations(deviceOrientations);

  final preferences = await SharedPreferences.getInstance();
  final bool hasSeenWelcome = preferences.getBool(hasSeenWelcomeKey) ?? false;

  runApp(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      theme: materialTheme,
      home: hasSeenWelcome ? DiceScreen() : WelcomeScreen(),
    ),
  );
}
