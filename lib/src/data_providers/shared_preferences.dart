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
    final instance = await sharedPreferencesInstance;

    if (T is String) {
      return instance.setString(key, value as String);
    } else if (T is int) {
      return instance.setInt(key, value as int);
    } else if (T is double) {
      return instance.setDouble(key, value as double);
    } else if (T is List<String>) {
      return instance.setStringList(
        key,
        value as List<String>,
      );
    }

    throw TypeError();
  }
}
