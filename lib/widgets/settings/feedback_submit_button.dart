import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FeedbackSubmitButton extends StatelessWidget {
  const FeedbackSubmitButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? Colors.grey.shade300 : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isLoading ? Colors.grey.shade400 : theme.primaryColorDark,
              width: 1,
            ),
          ),
          elevation: 0,
        ),
        icon:
            isLoading
                ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 2,
                  ),
                )
                : Icon(
                  Icons.send_outlined,
                  size: 18,
                  color: theme.primaryColorDark,
                ),
        label: Text(
          isLoading
              ? localizations.submittingFeedbackButton
              : localizations.submitFeedbackButton,
          style: TextStyle(
            color: isLoading ? Colors.grey.shade600 : theme.primaryColorDark,
            fontSize: theme.textTheme.labelLarge!.fontSize,
          ),
        ),
      ),
    );
  }
}
