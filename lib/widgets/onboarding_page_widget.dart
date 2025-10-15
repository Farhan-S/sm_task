import 'package:flutter/material.dart';

import '../models/onboarding_data.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingData data;
  final bool isLastPage;

  const OnboardingPageWidget({
    super.key,
    required this.data,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Image container
          SizedBox(
            height: 300,
            width: 300,
            child: Image.asset(data.imagePath, fit: BoxFit.contain),
          ),

          const SizedBox(height: 60),

          // Title
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
