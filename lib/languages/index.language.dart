const String englishUSCode = "en_US";
const String malaysiaMYCode = "ms_MY";
const String _defaultLanguageCode = englishUSCode;

String currentLanguageCode = _defaultLanguageCode;
Map<String, Map<String, String>> translatedLanguages = {};

setCurrentLanguageCode(languageCode) {
  languageCode = languageCode;
}

String translate({
  required String textCode,
  required String moduleName,
}) {
  return "";
}
