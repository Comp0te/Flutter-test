import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class SecureStorageRepository {
  static const tokenKey = 'token';

  final SecureStorageProvider storage;

  SecureStorageRepository({
    @required this.storage,
  }) : assert(storage != null);

  Future<bool> hasToken() async {
    var token = await storage.read(SecureStorageRepository.tokenKey);
    return token != null;
  }

  Future<String> getToken() async {
    return storage.read(SecureStorageRepository.tokenKey);
  }

  Future<void> deleteToken() async {
    storage.delete(SecureStorageRepository.tokenKey);
  }

  Future<void> clear() async {
    storage.clear();
  }

  Future<void> saveToken(String token) async {
    storage.write(
      key: SecureStorageRepository.tokenKey,
      value: token,
    );
  }
}
