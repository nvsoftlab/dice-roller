import 'package:flutter/material.dart';

class AppearanceSelector extends StatelessWidget {
  final List<Color> colors = const [
    Color(0xFFF28B6C), // Orange
    Color(0xFF5F3DFF), // Purple
    Color(0xFF27948C), // Teal
    Color(0xFFF4CA56), // Yellow (selected)
    Color(0xFFD0FF8A), // Light green
    Color(0xFFFF76F4), // Pink
  ];

  final int selectedIndex = 3;

  const AppearanceSelector({super.key}); // Yellow selected

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Background Color',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(colors.length, (index) {
                final isSelected = index == selectedIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    width: 32,
                    height: 32,
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
      ),
    );
  }
}
