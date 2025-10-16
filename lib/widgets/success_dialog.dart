import 'package:flutter/material.dart';

import 'primary_button.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onContinue;
  final String? imagePath;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onContinue,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade400,
                    size: 24,
                  ),
                  padding: EdgeInsets.only(right: -16, top: -16),
                  constraints: const BoxConstraints(),
                ),
              ),

              const SizedBox(height: 8),

              // Success icon with concentric circles and stars
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer circle (light blue)
                  Container(
                    width: 150,
                    height: 150,
                    child: Image(
                      image: AssetImage(
                        imagePath ?? 'lib/assets/images/success.png',
                      ),
                    ),
                  ),

                  // Middle circle (white)
                ],
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Message
              Text(
                message,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Continue button
              PrimaryButton(text: buttonText, onPressed: onContinue),
            ],
          ),
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onContinue,
    String? imagePath,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(
          title: title,
          message: message,
          buttonText: buttonText,
          onContinue: onContinue,
          imagePath: imagePath,
        );
      },
    );
  }
}
