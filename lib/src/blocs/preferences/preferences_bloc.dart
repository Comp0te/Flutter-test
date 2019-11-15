import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/databases/databases.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final KeyValueDatabaseRepository keyValueDatabaseRepository;

  PreferencesBloc({
    @required this.keyValueDatabaseRepository,
  }) : assert(keyValueDatabaseRepository != null);

  @override
  PreferencesState get initialState => PreferencesState.init();

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is RehydratePreferences) {
      yield* _mapRehydratePreferencesToState(event);
    } else if (event is ChooseLanguage) {
      yield* _mapChooseLanguageToState(event);
    } else if (event is ChooseThemeMode) {
      yield* _mapChooseThemeModeToState(event);
    }
  }

  Stream<PreferencesState> _mapRehydratePreferencesToState(
    RehydratePreferences event,
  ) async* {
    final languageIndex = await keyValueDatabaseRepository
            .read(SharedPreferencesKeys.languageIndex) ??
        SupportedLanguages.en.index.toString();
    final themeModeIndex = await keyValueDatabaseRepository
            .read(SharedPreferencesKeys.themeModeIndex) ??
        ThemeMode.system.index.toString();

    yield state.copyWith(
      locale: mapLanguagesEnumToLocale[languageIndex],
      themeMode: ThemeMode.values[int.parse(themeModeIndex)],
    );
  }

  Stream<PreferencesState> _mapChooseLanguageToState(
    ChooseLanguage event,
  ) async* {
    yield state.copyWith(
      locale: mapLanguagesEnumToLocale[event.language.index],
    );
    await keyValueDatabaseRepository.write(
      key: SharedPreferencesKeys.languageIndex,
      value: event.language.index.toString(),
    );
  }

  Stream<PreferencesState> _mapChooseThemeModeToState(
    ChooseThemeMode event,
  ) async* {
    yield state.copyWith(
      themeMode: event.themeMode,
    );
    await keyValueDatabaseRepository.write(
      key: SharedPreferencesKeys.themeModeIndex,
      value: event.themeMode.index.toString(),
    );
  }
}
