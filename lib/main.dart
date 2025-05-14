import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dice_roller/screens/dice.dart';

final materialTheme = ThemeData(
  primaryColor: Color(0xFFF1F4F8),
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFF1F4F8),
  cardColor: Colors.white,
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
      fontSize: 16,
      color: Color(0xFF14181B),
      fontWeight: FontWeight.w300,
    ),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: Colors.deepPurpleAccent,
    inactiveTrackColor: Color.fromARGB(
      // Replaced .withOpacity(0.3)
      (0.3 * 255).round(),
      Colors.deepPurpleAccent.red,
      Colors.deepPurpleAccent.green,
      Colors.deepPurpleAccent.blue,
    ),
    thumbColor: Colors.deepPurpleAccent,
    overlayColor: Color.fromARGB(
      // Replaced .withOpacity(0.2)
      (0.2 * 255).round(),
      Colors.deepPurpleAccent.red,
      Colors.deepPurpleAccent.green,
      Colors.deepPurpleAccent.blue,
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
    ),
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
        // Replaced Colors.deepPurpleAccent.withOpacity(0.5)
        return Color.fromARGB(
          (0.5 * 255).round(),
          Colors.deepPurpleAccent.red,
          Colors.deepPurpleAccent.green,
          Colors.deepPurpleAccent.blue,
        );
      }
      // Replaced Colors.grey.withOpacity(0.5)
      // Note: Colors.grey is a MaterialColor, Colors.grey.shade500 is the default grey
      // but Colors.grey itself is also a Color(0xFF9E9E9E)
      final greyBase = Colors.grey; // This is Color(0xFF9E9E9E)
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
    backgroundColor: Color(0xFFF1F4F8),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  ),
);

void main() {
  runApp(MaterialApp(theme: materialTheme, home: DiceScreen()));
}
