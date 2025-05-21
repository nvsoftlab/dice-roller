import 'package:flutter/material.dart';

class ScoreSectionLayout extends StatelessWidget {
  const ScoreSectionLayout({
    super.key,
    required this.content,
    required this.title,
    required this.totalScoreWidget,
  });

  final Widget content;
  final String title;
  final Widget totalScoreWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                totalScoreWidget,
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 4, thickness: 1),
            content,
          ],
        ),
      ),
    );
  }
}
