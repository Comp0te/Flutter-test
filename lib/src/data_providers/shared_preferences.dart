import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final Future<SharedPreferences> sharedPreferencesInstance;

  SharedPreferencesProvider({
    @required this.sharedPreferencesInstance,
  }) : assert(sharedPreferencesInstance != null);

  Future<T> read<T>(String key) async {
    final instance = await sharedPreferencesInstance;

    return instance.get(key) as T;
  }

  Future<bool> contains(String key) async {
    final instance = await sharedPreferencesInstance;

    return instance.containsKey(key);
  }

  Future<bool> delete(String key) async {
    final instance = await sharedPreferencesInstance;

    return instance.remove(key);
  }

  Future<bool> clear() async {
    final instance = await sharedPreferencesInstance;

    return instance.clear();
  }

  Future<bool> write<T>({@required String key, @required T value}) async {
    assert(T != null);
    final instance = await sharedPreferencesInstance;

    if (T == String) {
      return instance.setString(key, value as String);
    } else if (T == int) {
      return instance.setInt(key, value as int);
    } else if (T == double) {
      return instance.setDouble(key, value as double);
    }

    throw TypeError();
  }

  Future<bool> writeList({
    @required String key,
    @required List<String> values,
  }) async {
    final instance = await sharedPreferencesInstance;

    return instance.setStringList(key, values);
  }
}
