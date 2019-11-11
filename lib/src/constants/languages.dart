import 'package:flutter/material.dart';

enum SupportedLanguages { en, ru }

const englishLanguageCode = 'en';
const russianLanguageCode = 'ru';
const defaultLocale = Locale(englishLanguageCode, '');

SupportedLanguages getLanguage(String languageCode) {
  if (languageCode == russianLanguageCode) {
    return SupportedLanguages.ru;
  }

  return SupportedLanguages.en;
}

String getLanguageCode(SupportedLanguages language) {
  switch (language) {
    case SupportedLanguages.en:
      return englishLanguageCode;
    case SupportedLanguages.ru:
      return russianLanguageCode;
    default:
      return englishLanguageCode;
  }
}

const mapLanguagesEnumToLocale = <SupportedLanguages, Locale>{
  SupportedLanguages.en: defaultLocale,
  SupportedLanguages.ru: Locale(russianLanguageCode, ''),
};
