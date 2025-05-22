import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FeedbackSubmitButton extends StatelessWidget {
  const FeedbackSubmitButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(
          Icons.send_outlined,
          size: 18,
          color: theme.primaryColorDark,
        ),
        label: Text(
          localizations.submitFeedbackButton,
          style: TextStyle(
            color: theme.primaryColorDark,
            fontSize: theme.textTheme.labelLarge!.fontSize,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.primaryColorDark, width: 1),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
