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
          const Spacer(flex: 1),

          // Image container
          Flexible(
            flex: 3,
            child: SizedBox(
              height: 280,
              width: 280,
              child: Image.asset(data.imagePath, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(height: 40),

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              data.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
