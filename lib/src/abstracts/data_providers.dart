import 'dart:io' as io;

import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

abstract class DatabaseProvider {
  const DatabaseProvider();

  Future<void> insertPosters(List<PosterNormalized> posters) async {}

  Future<void> insertUsers(List<User> users) async {}

  Future<void> insertPosterImages(List<PosterNormalized> posters) async {}

  Future<List<Map<String, dynamic>>> getPosters() async {
    return [];
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    return [];
  }

  Future<List<Map<String, dynamic>>> getPosterImages() async {
    return [];
  }
}

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
