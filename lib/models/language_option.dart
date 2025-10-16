class LanguageOption {
  final String name;
  final String code;
  final String flagPath;
  bool isSelected;

  LanguageOption({
    required this.name,
    required this.code,
    required this.flagPath,
    this.isSelected = false,
  });
}
