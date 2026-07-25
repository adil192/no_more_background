import 'package:sealed_languages/sealed_languages.dart';

String getNativeName(String localeCode) {
  return switch (localeCode) {
    'fil' => 'Pilipino',
    'zh-Hans' => '中文（简体）',
    'zh-Hant' => '中文（繁體）',
    _ => NaturalLanguage.fromAnyCode(localeCode).namesNative.first,
  };
}
