class OnboardingData {
  final String title;
  final String description;
  final String imagePath; // Placeholder for now
  final String buttonText;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.buttonText,
  });

  static List<OnboardingData> get pages => [
    const OnboardingData(
      title: 'Best online courses in the world',
      description:
          'Now you can learn anywhere, anytime, even if there is no internet access!',
      imagePath: 'lib/assets/images/onboarding.png',
      buttonText: 'Next',
    ),
    const OnboardingData(
      title: 'Explore your new skill today',
      description:
          'Our platform is designed to help you explore new skills. Let\'s learn & grow with Eduline!',
      imagePath: 'lib/assets/images/onboarding1.png',
      buttonText: 'Get Started',
    ),
  ];
}
