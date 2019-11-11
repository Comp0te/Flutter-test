import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class PreferencesState extends EquatableClass {
  final Locale locale;

  PreferencesState({
    @required this.locale,
  });

  factory PreferencesState.init() => PreferencesState(
        locale: defaultLocale,
      );

  PreferencesState copyWith({
    Locale locale,
  }) {
    return PreferencesState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [locale];
}
