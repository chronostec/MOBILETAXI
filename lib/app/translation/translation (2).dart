abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUS,
    "es": es,
    "fr": fr
  };
}

final Map<String, String> enUS = {
  'greeting': 'Hello, How are you?',
  'day': "Awesome day..."
};

final Map<String, String> es = {
  'greeting': "¿Hola como estas?",
  'day': "Día impresionante..."
};

final Map<String, String> fr = {
  'greeting': "Salut comment allez-vous?",
  'day': "Super journée..."
};
