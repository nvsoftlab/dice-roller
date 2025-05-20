import 'package:flutter/material.dart';

class ColorUtils {
  static Color getLighterColor(Color color, [double amount = 0.1]) {
    HSLColor hslColor = HSLColor.fromColor(color);
    HSLColor lighterHslColor = hslColor.withLightness(
      (hslColor.lightness + amount).clamp(0.0, 1.0),
    );
    return lighterHslColor.toColor();
  }

  static Color getTextColorForBackground(Color backgroundColor) {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(
      backgroundColor,
    );
    return brightness == Brightness.light ? Colors.black87 : Colors.white;
  }
}
