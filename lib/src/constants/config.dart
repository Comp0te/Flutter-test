import 'dart:io';

abstract class Url {
  static final base = 'http://light-it-04.tk/api/';
  static final login = 'login/';
  static final register = 'registration/';
  static final tokenVerify = 'token-verify/';
  static final posters = 'posters/';
}

abstract class DbConfig {
  static final dbName = 'postres.db';
  static final dbVersion = 1;
}

final urlProxyMan =
    Platform.isAndroid ? '172.16.101.77:9090' : 'localhost:9090';
