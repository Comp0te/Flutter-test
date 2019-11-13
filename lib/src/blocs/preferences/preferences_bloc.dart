import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/databases/databases.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final SharedPreferencesRepository sharedPreferencesRepository;

  PreferencesBloc({
    @required this.sharedPreferencesRepository,
  }) : assert(sharedPreferencesRepository != null);

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
    final languageIndex = await sharedPreferencesRepository
        .read<int>(SharedPreferencesKeys.languageIndex);
    final themeModeIndex = await sharedPreferencesRepository
            .read<int>(SharedPreferencesKeys.themeModeIndex) ??
        ThemeMode.system.index;

    yield state.copyWith(
      locale: mapLanguagesEnumToLocale[languageIndex],
      themeMode: ThemeMode.values[themeModeIndex],
    );
  }

  Stream<PreferencesState> _mapChooseLanguageToState(
    ChooseLanguage event,
  ) async* {
    yield state.copyWith(
      locale: mapLanguagesEnumToLocale[event.language.index],
    );
    await sharedPreferencesRepository.write<int>(
      key: SharedPreferencesKeys.languageIndex,
      value: event.language.index,
    );
  }

  Stream<PreferencesState> _mapChooseThemeModeToState(
    ChooseThemeMode event,
  ) async* {
    yield state.copyWith(
      themeMode: event.themeMode,
    );
    await sharedPreferencesRepository.write<int>(
      key: SharedPreferencesKeys.themeModeIndex,
      value: event.themeMode.index,
    );
  }
}
