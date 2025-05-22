import 'package:dice_roller/constants/shared_preferences_indexes.dart';
import 'package:dice_roller/widgets/welcome/welcome_features_section.dart';
import 'package:dice_roller/widgets/welcome/welcome_header.dart';
import 'package:flutter/material.dart';
import 'package:dice_roller/screens/dice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _markWelcomeSeenAndNavigate(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(hasSeenWelcomeKey, true);

    if (!context.mounted) {
      return;
    }

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => const DiceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeHeader(),
              WelcomeFeaturesSection(
                onLetsRoll: () => _markWelcomeSeenAndNavigate(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
