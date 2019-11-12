import 'package:equatable/equatable.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class RehydratePreferences extends PreferencesEvent {
  @override
  List<Object> get props => [];
}

class ChooseLanguage extends PreferencesEvent {
  final SupportedLanguages language;

  ChooseLanguage(this.language);

  @override
  List<Object> get props => [language];
}