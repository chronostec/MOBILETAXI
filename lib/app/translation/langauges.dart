final List<LanguageModel> languages = [
  LanguageModel("English", "en_US"),
  LanguageModel("Spanish", "es"),
  LanguageModel("French", "fr"),
];

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
  );

  String language;
  String symbol;
}
