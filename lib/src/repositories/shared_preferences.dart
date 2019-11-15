import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

class SharedPreferencesRepository implements KeyValueDatabaseRepository {
  @override
  final KeyValueDatabaseProvider keyValueDatabaseProvider;

  SharedPreferencesRepository({
    @required this.keyValueDatabaseProvider,
  }) : assert(keyValueDatabaseProvider != null);

  @override
  Future<String> read(String key) async {
    return keyValueDatabaseProvider.read(key);
  }

  @override
  Future<bool> contains(String key) async {
    return keyValueDatabaseProvider.contains(key);
  }

  @override
  Future<void> delete(String key) async {
    return keyValueDatabaseProvider.delete(key);
  }

  @override
  Future<void> clear() async {
    return keyValueDatabaseProvider.clear();
  }

  @override
  Future<void> write({@required String key, @required String value}) async {
    return keyValueDatabaseProvider.write(key: key, value: value);
  }
}
