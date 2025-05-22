import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FeedbackFormFields extends StatelessWidget {
  const FeedbackFormFields({
    super.key,
    required this.emailController,
    required this.feedbackController,
  });

  final TextEditingController emailController;
  final TextEditingController feedbackController;

  static const Color _inputBorderColor = Color(0xFFE0E3E7);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.emailLabel, style: theme.textTheme.labelMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: localizations.emailHint,
            hintStyle: theme.textTheme.labelMedium!.copyWith(fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: _inputBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: _inputBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
            ),
            filled: true,
            fillColor: const Color(0xFFF1F4F8),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return localizations.validationPleaseEnterEmail;
            }
            if (!RegExp(
              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
            ).hasMatch(value)) {
              return localizations.validationPleaseEnterValidEmail;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Text(localizations.tellUsMoreLabel, style: theme.textTheme.labelMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: feedbackController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: localizations.tellUsMoreHint,
            hintStyle: theme.textTheme.labelMedium!.copyWith(fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: _inputBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: _inputBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
            ),
            filled: true,
            fillColor: const Color(0xFFF1F4F8),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return localizations.validationPleaseTellUsMore;
            }
            return null;
          },
        ),
      ],
    );
  }
}
