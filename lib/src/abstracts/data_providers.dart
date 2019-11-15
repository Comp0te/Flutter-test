import 'package:meta/meta.dart';

abstract class KeyValueDatabaseProvider {
  const KeyValueDatabaseProvider();

  Future<String> read(String key) async {
    return Future.value();
  }

  Future<bool> contains(String key) async {
    return Future.value();
  }

  Future<void> delete(String key) async {}

  Future<void> clear() async {}

  Future<void> write({@required String key, @required String value}) async {}
}
