import 'package:dice_roller/widgets/settings/settings_section_layout.dart';
import 'package:flutter/material.dart';

class SettingsAppearanceSection extends StatefulWidget {
  const SettingsAppearanceSection({super.key});

  @override
  State<SettingsAppearanceSection> createState() =>
      _SettingsAppearanceSectionState();
}

class _SettingsAppearanceSectionState extends State<SettingsAppearanceSection> {
  final List<Color> colors = const [
    Color(0xFFF28B6C), // Orange
    Color(0xFF5F3DFF), // Purple
    Color(0xFF27948C), // Teal
    Color(0xFFF4CA56), // Yellow (selected)
    Color(0xFFD0FF8A), // Light green
    Color(0xFFFF76F4), // Pink
  ];

  final int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionLayout(
      content: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space between label and color row
        children: [
          Text(
            'Background Color',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            children: List.generate(colors.length, (index) {
              final isSelected = index == selectedIndex;
              return Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ), // 8px space between each color
                child: Container(
                  width: 24, // Adjusted width
                  height: 24, // Adjusted height
                  decoration: BoxDecoration(
                    color: colors[index],
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
