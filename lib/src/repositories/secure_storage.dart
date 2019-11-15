import 'package:meta/meta.dart';

import 'package:flutter_app/src/databases/databases.dart';
import 'package:flutter_app/src/data_providers/data_providers.dart';

class SecureStorageRepository {
  final SecureStorageProvider storage;

  SecureStorageRepository({
    @required this.storage,
  }) : assert(storage != null);

  Future<bool> hasToken() async {
    return storage.contains(SecureStorageKeys.token);
  }

  Future<String> getToken() async {
    return storage.read(SecureStorageKeys.token);
  }

  Future<void> deleteToken() async {
    await storage.delete(SecureStorageKeys.token);
  }

  Future<void> clear() async {
    await storage.clear();
  }

  Future<void> saveToken(String token) async {
    await storage.write(
      key: SecureStorageKeys.token,
      value: token,
    );
  }
}
