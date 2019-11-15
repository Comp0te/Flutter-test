import 'dart:io' as io;

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

abstract class ImageDatabaseProvider {
  Future<io.File> getImage(String url) async {
    return null;
  }

  Future<void> computeSaveImage(String url) async {}
}