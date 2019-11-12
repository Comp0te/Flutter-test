import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class SharedPreferencesRepository {
  final SharedPreferencesProvider sharedPreferencesProvider;

  SharedPreferencesRepository({
    @required this.sharedPreferencesProvider,
  }) : assert(sharedPreferencesProvider != null);

  Future<T> read<T>(String key) async {
    return sharedPreferencesProvider.read<T>(key);
  }

  Future<bool> contains(String key) async {
    return sharedPreferencesProvider.contains(key);
  }

  Future<bool> delete(String key) async {
    return sharedPreferencesProvider.delete(key);
  }

  Future<bool> clear() async {
    return sharedPreferencesProvider.clear();
  }

  Future<bool> write<T>({@required String key, @required T value}) async {
    return sharedPreferencesProvider.write<T>(key: key, value: value);
  }
}
