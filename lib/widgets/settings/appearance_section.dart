import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/settings_section_layout.dart';
import 'package:flutter/material.dart';

class AppearanceSection extends StatefulWidget {
  const AppearanceSection({super.key});

  @override
  State<AppearanceSection> createState() => _AppearanceSectionState();
}

class _AppearanceSectionState extends State<AppearanceSection> {
  final int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SettingsSectionLayout(
      title: localizations.settingsAppearanceTitle,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localizations.settingsAppearanceBgColor,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            children: List.generate(kColors.length, (index) {
              final isSelected = index == selectedIndex;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: kColors[index],
                    shape: BoxShape.circle,
                    border:
                        isSelected
                            ? Border.all(color: Colors.deepPurple, width: 2)
                            : null,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
