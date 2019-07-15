import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageProvider {
  final FlutterSecureStorage secureStorage;

  SecureStorageProvider({
    @required this.secureStorage,
  }) : assert(secureStorage != null);

  Future<String> read(String key) async {
    return secureStorage.read(key: key);
  }

  Future<Map<String, String>> readAll() async {
    return secureStorage.readAll();
  }

  Future<void> delete(String key) async {
    secureStorage.delete(key: key);
  }

  Future<void> clear() async {
    secureStorage.deleteAll();
  }

  Future<void> write({
    @required String key,
    @required String value,
  }) async {
    secureStorage.write(key: key, value: value);
  }
}
