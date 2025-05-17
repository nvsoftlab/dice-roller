import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/current_color_indicator.dart';
import 'package:dice_roller/widgets/settings/settings_section_layout.dart';
import 'package:dice_roller/constants/shared_preferences_indexes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceSection extends StatefulWidget {
  const AppearanceSection({super.key});

  @override
  State<AppearanceSection> createState() => _AppearanceSectionState();
}

class _AppearanceSectionState extends State<AppearanceSection> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadSelectedColor();
  }

  Future<void> _loadSelectedColor() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;

    int? newSelectedIndex;
    int? storedIndex = preferences.getInt(selectedColorIndexKey);

    if (storedIndex == null) {
      // Preference is null, default to 0 (index for kColors[0]).
      newSelectedIndex = 0;
    } else if (storedIndex >= 0 && storedIndex < kColors.length) {
      // Preference exists and is a valid index for kColors.
      newSelectedIndex = storedIndex;
    } else {
      // Preference exists but is out of bounds for kColors, default to 0.
      newSelectedIndex = 0;
    }

    setState(() {
      _selectedIndex = newSelectedIndex;
    });
  }

  Future<void> _saveSelectedColor(int index) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(selectedColorIndexKey, index);
  }

  Widget _buildBottomSheetColorGrid(
    BuildContext sheetContext,
    int? currentGridSelectionIndex,
    ValueChanged<int> onColorSelected,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: kColors.length,
      itemBuilder: (context, index) {
        final bool isSelected = index == currentGridSelectionIndex;

        return Center(
          child: CurrentColorIndicator(
            color: kColors[index],
            onTap: () => onColorSelected(index),
            isSelected: isSelected,
            size: 50,
          ),
        );
      },
    );
  }

  Future<void> _showColorPickerBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context, // Parent context
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (BuildContext bottomSheetContext) {
        // StatefulBuilder to manage sheet's internal state
        return StatefulBuilder(
          builder: (
            BuildContext statefulBuilderContext,
            StateSetter modalSetState,
          ) {
            int? tempSelectedIndex = _selectedIndex;

            return Padding(
              padding: EdgeInsets.fromLTRB(
                10,
                10,
                10,
                1 + MediaQuery.of(statefulBuilderContext).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBottomSheetColorGrid(
                    statefulBuilderContext,
                    tempSelectedIndex,
                    (int index) {
                      modalSetState(() {
                        // updates state in the sheet's UI
                        tempSelectedIndex = index;
                      });
                      setState(() {
                        // updates _AppearanceSectionState
                        _selectedIndex = index;
                      });
                      // updates shared_preferences
                      _saveSelectedColor(index);
                      Navigator.pop(statefulBuilderContext);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SettingsSectionLayout(
      title: localizations.settingsAppearanceTitle,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localizations.settingsAppearanceBgColor,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          CurrentColorIndicator(
            color: kColors[_selectedIndex!],
            onTap: () => _showColorPickerBottomSheet(context),
            size: 30,
            isSelected: true,
          ),
        ],
      ),
    );
  }
}
