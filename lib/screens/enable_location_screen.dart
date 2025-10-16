import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/circular_back_button.dart';
import '../widgets/primary_button.dart';
import 'select_language_screen.dart';

class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  void _handleEnableLocation(BuildContext context) {
    // Navigate to language selection screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SelectLanguageScreen()),
    );
  }

  void _handleSkip(BuildContext context) {
    // Navigate to language selection screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SelectLanguageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),


                      const Spacer(flex: 1),

                      // Map illustration
                      Center(
                        child: Image.asset(
                          'lib/assets/images/Maps.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Title
                      const Center(
                        child: Text(
                          'Enable Location',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Kindly allow us to access your location to provide you with suggestions for nearby salons',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      const Spacer(flex: 1),

                      // Enable Location button
                      PrimaryButton(
                        text: 'Enable',
                        onPressed: () => _handleEnableLocation(context),
                      ),

                      const SizedBox(height: 16),

                      // Skip button
                      Center(
                        child: TextButton(
                          onPressed: () => _handleSkip(context),
                          child: Text(
                            'Skip, Not Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
