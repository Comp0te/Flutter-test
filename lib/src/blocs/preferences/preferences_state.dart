import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class PreferencesState extends EquatableClass {
  final Locale locale;
  final ThemeMode themeMode;

  PreferencesState({
    @required this.locale,
    @required this.themeMode,
  });

  factory PreferencesState.init() => PreferencesState(
        locale: defaultLocale,
        themeMode: ThemeMode.system,
      );

  PreferencesState copyWith({
    Locale locale,
    ThemeMode themeMode,
  }) {
    return PreferencesState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [locale, themeMode];
}
