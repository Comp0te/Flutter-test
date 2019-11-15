import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

class SecureStorageProvider implements KeyValueDatabaseProvider {
  final FlutterSecureStorage secureStorage;

  const SecureStorageProvider({
    @required this.secureStorage,
  }) : assert(secureStorage != null);

  @override
  Future<String> read(String key) async {
    return secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<void> write({
    @required String key,
    @required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<bool> contains(String key) async {
    final value = secureStorage.read(key: key);

    return value != null;
  }
}
