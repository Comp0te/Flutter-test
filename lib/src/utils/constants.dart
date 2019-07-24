abstract class AuthRouteNames {
  static const login = '/';
  static const register = '/register';
}

abstract class MainRouteNames {
  static const home = '/';
}

abstract class Url {
  static final base = 'http://light-it-04.tk/api/';
  static final login = 'login/';
  static final register = 'registration/';
  static final posters = 'posters/';
}

abstract class DbConfig {
  static final dbName = 'postres.db';
  static final dbVersion = 1;

}