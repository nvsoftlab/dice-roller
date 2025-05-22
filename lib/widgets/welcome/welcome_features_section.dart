import 'package:dice_roller/widgets/welcome/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:dice_roller/l10n/app_localizations.dart';

class WelcomeFeaturesSection extends StatelessWidget {
  final VoidCallback onLetsRoll;

  const WelcomeFeaturesSection({super.key, required this.onLetsRoll});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              localizations.welcomeScreenHowToUseTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 25),
            FeatureItem(
              number: '1',
              title: localizations.welcomeScreenFeature1Title,
              description: localizations.welcomeScreenFeature1Description,
            ),
            const SizedBox(height: 15),
            FeatureItem(
              number: '2',
              title: localizations.welcomeScreenFeature2Title,
              description: localizations.welcomeScreenFeature2Description,
            ),
            const SizedBox(height: 15),
            FeatureItem(
              number: '3',
              title: localizations.welcomeScreenFeature3Title,
              description: localizations.welcomeScreenFeature3Description,
            ),
            const SizedBox(height: 15),
            FeatureItem(
              number: '4',
              title: localizations.welcomeScreenFeature4Title,
              description: localizations.welcomeScreenFeature4Description,
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onLetsRoll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    localizations.welcomeScreenLetsRollButton,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
