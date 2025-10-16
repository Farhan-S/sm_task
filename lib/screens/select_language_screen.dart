import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_task/screens/enable_location_screen.dart';

import '../models/language_option.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/language_selection_item.dart';
import '../widgets/primary_button.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  List<LanguageOption> languages = [
    LanguageOption(
      name: 'English (US)',
      code: 'en_US',
      flagPath: 'lib/assets/images/flags/us.png',
      isSelected: true,
    ),
    LanguageOption(
      name: 'Indonesia',
      code: 'id',
      flagPath: 'lib/assets/images/flags/indonesia.png',
    ),
    LanguageOption(
      name: 'Afghanistan',
      code: 'af',
      flagPath: 'lib/assets/images/flags/afghanistan.png',
    ),
    LanguageOption(
      name: 'Algeria',
      code: 'dz',
      flagPath: 'lib/assets/images/flags/algeria.png',
    ),
    LanguageOption(
      name: 'Malaysia',
      code: 'my',
      flagPath: 'lib/assets/images/flags/malaysia.png',
    ),
    LanguageOption(
      name: 'Arabic',
      code: 'ar',
      flagPath: 'lib/assets/images/flags/uae.png',
    ),
  ];

  void _selectLanguage(int index) {
    setState(() {
      for (var i = 0; i < languages.length; i++) {
        languages[i].isSelected = i == index;
      }
    });
  }

  void _handleContinue() {
    // Navigate to home or next screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Language selected: ${languages.firstWhere((l) => l.isSelected).name}',
        ),
        backgroundColor: Colors.green,
      ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Back button
                    CircularBackButton(
                      onPressed: ()=> { // Navigate to language selection screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const EnableLocationScreen()),
                      )}
                    ),

                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'What is Your Mother Language',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    Text(
                      'Discover what is a podcast description and podcast summary.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),

              // Language list
              Expanded(
                child: Container(
                  color: const Color(0xFFFAFAFA), // Light background color
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      return LanguageSelectionItem(
                        languageName: language.name,
                        flagPath: language.flagPath,
                        isSelected: language.isSelected,
                        onSelect: () => _selectLanguage(index),
                      );
                    },
                  ),
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.all(24),
                child: PrimaryButton(
                  text: 'Continue',
                  onPressed: _handleContinue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
