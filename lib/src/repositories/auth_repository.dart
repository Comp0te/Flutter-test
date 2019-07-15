import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class AuthRepository {
  static const tokenKey = 'token';

  final SecureStorageProvider storage;

  AuthRepository({
    @required this.storage,
  }) : assert(storage != null);

  Future<bool> hasToken() async {
    return storage.read(AuthRepository.tokenKey) != null;
  }

  Future<String> getToken() async {
    return storage.read(AuthRepository.tokenKey);
  }

  Future<void> deleteToken() async {
    storage.delete(AuthRepository.tokenKey);
  }

  Future<void> clear() async {
    storage.clear();
  }

  Future<void> saveToken(String token) async {
    storage.write(
      key: AuthRepository.tokenKey,
      value: token,
    );
  }
}
