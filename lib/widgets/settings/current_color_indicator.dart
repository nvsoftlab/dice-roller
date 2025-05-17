import 'package:dice_roller/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

class CurrentColorIndicator extends StatelessWidget {
  const CurrentColorIndicator({
    super.key,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.size,
  });

  final Color color;
  final VoidCallback onTap;
  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child:
            isSelected
                ? Icon(
                  Icons.check,
                  color: color.isDark ? Colors.white : Colors.black,
                  size: size * 0.7,
                )
                : null,
      ),
    );
  }
}
