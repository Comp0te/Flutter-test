import 'package:flutter/material.dart';

enum SupportedLanguages { en, ru }

final mapLanguagesEnumToLocale = <SupportedLanguages, Locale>{
  SupportedLanguages.en: const Locale('en', ''),
  SupportedLanguages.ru: const Locale('ru', ''),
};
