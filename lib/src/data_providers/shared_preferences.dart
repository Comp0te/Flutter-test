import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

class SharedPreferencesProvider implements KeyValueDatabaseProvider {
  final Future<SharedPreferences> sharedPreferencesInstance;

  const SharedPreferencesProvider({
    @required this.sharedPreferencesInstance,
  }) : assert(sharedPreferencesInstance != null);

  @override
  Future<String> read(String key) async {
    final instance = await sharedPreferencesInstance;

    return instance.getString(key);
  }

  @override
  Future<bool> contains(String key) async {
    final instance = await sharedPreferencesInstance;

    return instance.containsKey(key);
  }

  @override
  Future<void> delete(String key) async {
    final instance = await sharedPreferencesInstance;

    await instance.remove(key);
  }

  @override
  Future<void> clear() async {
    final instance = await sharedPreferencesInstance;

    await instance.clear();
  }

  @override
  Future<void> write({
    @required String key,
    @required String value,
  }) async {
    final instance = await sharedPreferencesInstance;

    await instance.setString(key, value);
  }
}
