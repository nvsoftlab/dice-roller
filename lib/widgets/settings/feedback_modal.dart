import 'package:dice_roller/l10n/app_localizations.dart';
import 'package:dice_roller/widgets/settings/feedback_form_fields.dart';
import 'package:dice_roller/widgets/settings/feedback_submit_button.dart';
import 'package:dice_roller/widgets/settings/rating_option.dart';
import 'package:flutter/material.dart';

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({super.key});

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  String? _selectedRating;
  bool _ratingValidationError = false;

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

  void _submitFeedback() {
    final isFormValid = _formKey.currentState!.validate();
    final isRatingSelected = _selectedRating != null;

    setState(() {
      _ratingValidationError = !isRatingSelected;
    });

    if (isFormValid && isRatingSelected) {
      print('Rating: $_selectedRating');
      print('Email: ${_emailController.text}');
      print('Feedback: ${_feedbackController.text}');
      Navigator.of(context).pop(); // Close the dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Feedback submitted!',
            style: TextStyle(
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
          duration: Duration(seconds: 3),
        ),
      );
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
                      isSelected: _selectedRating == localizations.ratingPoor,
                      onTap:
                          () => _handleRatingSelected(localizations.ratingPoor),
                    ),
                    RatingOption(
                      label: localizations.ratingFair,
                      iconData: Icons.sentiment_dissatisfied,
                      color: Colors.orange,
                      isSelected: _selectedRating == localizations.ratingFair,
                      onTap:
                          () => _handleRatingSelected(localizations.ratingFair),
                    ),
                    RatingOption(
                      label: localizations.ratingOkay,
                      iconData: Icons.sentiment_satisfied,
                      color: Colors.amber,
                      isSelected: _selectedRating == localizations.ratingOkay,
                      onTap:
                          () => _handleRatingSelected(localizations.ratingOkay),
                    ),
                    RatingOption(
                      label: localizations.ratingGood,
                      iconData: Icons.sentiment_very_satisfied,
                      color: Colors.green,
                      isSelected: _selectedRating == localizations.ratingGood,
                      onTap:
                          () => _handleRatingSelected(localizations.ratingGood),
                    ),
                  ],
                ),
                if (_ratingValidationError)
                  Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      'Please select a rating',
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                FeedbackFormFields(
                  emailController: _emailController,
                  feedbackController: _feedbackController,
                ),
                const SizedBox(height: 24),
                FeedbackSubmitButton(onPressed: _submitFeedback),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
