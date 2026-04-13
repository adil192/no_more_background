import 'package:sealed_languages/sealed_languages.dart';

String getNativeName(String localeCode) {
  return switch (localeCode) {
    'zh-Hans' => '中文（简体）',
    _ => NaturalLanguage.fromAnyCode(localeCode).namesNative.first,
  };
}
