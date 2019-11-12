import 'package:flutter/material.dart';

enum SupportedLanguages { en, ru }

const defaultLocale = Locale('en', '');

final mapLanguagesEnumToLocale = <int, Locale>{
  SupportedLanguages.en.index: defaultLocale,
  SupportedLanguages.ru.index: const Locale('ru', ''),
};
