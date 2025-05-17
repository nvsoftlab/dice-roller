import 'package:flutter/material.dart';

extension ColorBrightness on Color {
  bool get isDark => computeLuminance() < 0.5;
}
