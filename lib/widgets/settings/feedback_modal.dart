import 'dart:convert';

import 'package:dice_roller/constants/config.dart';
import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/feedback_form_fields.dart';
import 'package:dice_roller/widgets/settings/feedback_submit_button.dart';
import 'package:dice_roller/widgets/settings/rating_option.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({super.key});

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  String? _selectedRating;
  bool _ratingValidationError = false;
  bool _apiError = false;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _handleRatingSelected(String label) {
    setState(() {
      _selectedRating = label;
      _ratingValidationError = false;
    });
  }

  void _submitFeedback() async {
    final currentContext = context;
    final localizations = AppLocalizations.of(currentContext)!;

    final isFormValid = _formKey.currentState!.validate();
    final isRatingSelected = _selectedRating != null;

    setState(() {
      _ratingValidationError = !isRatingSelected;
      _apiError = false;
    });

    if (isFormValid && isRatingSelected) {
      setState(() {
        _isLoading = true;
      });

      final Map<String, String> feedbackData = {
        'rating': _selectedRating!,
        'email': _emailController.text,
        'feedback': _feedbackController.text,
      };

      try {
        await http.post(
          Uri.parse(kGoogleSpreadsheetsScriptUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(feedbackData),
        );

        if (!currentContext.mounted) return;

        ScaffoldMessenger.of(currentContext).showSnackBar(
          SnackBar(
            content: Text(
              localizations.feedbackSubmittedSnackbar,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.black87,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(currentContext).pop();
      } catch (e) {
        if (!currentContext.mounted) return;
        setState(() {
          _apiError = true;
        });
      } finally {
        if (currentContext.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations.modalShareFeedbackTitle,
                      style: theme.textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.modalRatingQuestion,
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RatingOption(
                      label: localizations.ratingPoor,
                      iconData: Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                      isSelected: _selectedRating == kRating['poor']!,
                      onTap: () => _handleRatingSelected(kRating['poor']!),
                    ),
                    RatingOption(
                      label: localizations.ratingFair,
                      iconData: Icons.sentiment_dissatisfied,
                      color: Colors.orange,
                      isSelected: _selectedRating == kRating['fair']!,
                      onTap: () => _handleRatingSelected(kRating['fair']!),
                    ),
                    RatingOption(
                      label: localizations.ratingOkay,
                      iconData: Icons.sentiment_satisfied,
                      color: Colors.amber,
                      isSelected: _selectedRating == kRating['okay']!,
                      onTap: () => _handleRatingSelected(kRating['okay']!),
                    ),
                    RatingOption(
                      label: localizations.ratingGood,
                      iconData: Icons.sentiment_very_satisfied,
                      color: Colors.green,
                      isSelected: _selectedRating == kRating['good']!,
                      onTap: () => _handleRatingSelected(kRating['good']!),
                    ),
                  ],
                ),
                if (_ratingValidationError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      localizations.ratingRequiredError,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                FeedbackFormFields(
                  emailController: _emailController,
                  feedbackController: _feedbackController,
                ),
                if (_apiError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      localizations.feedbackApiError,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                FeedbackSubmitButton(
                  onPressed: _isLoading ? null : _submitFeedback,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
