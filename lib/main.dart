import 'package:dice_roller/screens/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<DeviceOrientation> deviceOrientations = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(deviceOrientations).then((_) {
    runApp(MaterialApp(home: DiceScreen()));
  });
}
