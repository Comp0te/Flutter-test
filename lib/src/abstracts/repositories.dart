import 'dart:io' as io;

import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

abstract class KeyValueDatabaseRepository {
  final KeyValueDatabaseProvider keyValueDatabaseProvider;

  const KeyValueDatabaseRepository({this.keyValueDatabaseProvider});

  Future<String> read(String key) async {
    return keyValueDatabaseProvider.read(key);
  }

  Future<bool> contains(String key) async {
    return keyValueDatabaseProvider.contains(key);
  }

  Future<void> delete(String key) async {
    await keyValueDatabaseProvider.delete(key);
  }

  Future<void> clear() async {
    await keyValueDatabaseProvider.clear();
  }

  Future<void> write({
    @required String key,
    @required String value,
  }) async {
    await keyValueDatabaseProvider.write(key: key, value: value);
  }
}

abstract class ImageDatabaseRepository {
  final ImageDatabaseProvider imageDatabaseProvider;

  const ImageDatabaseRepository({this.imageDatabaseProvider});

  Future<io.File> getImage(String url) async {
    return imageDatabaseProvider.getImage(url);
  }

  Future<void> saveImage(String url) async {
    return imageDatabaseProvider.computeSaveImage(url);
  }
}
