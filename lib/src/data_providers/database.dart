import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../database/tables.dart';

class DBProvider {
  final Database db;

  DBProvider({
    @required this.db,
  }) : assert(db != null);

  Future<void> insertPosters(List<PosterNormalized> posters) async {
    Batch batch = db.batch();

    try {
      posters.forEach((poster) {
        batch.insert(
          PostersTable.name,
          poster.toJson()..removeWhere((posterKey, _) => posterKey == 'images'),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

      return batch.commit();
    } catch (err) {
      print('---===insertPosters - $err');
    }
  }

  Future<void> insertUsers(List<User> users) async {
    Batch batch = db.batch();

    try {
      users.forEach((user) => batch.insert(
            UsersTable.name,
            user.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          ));

      return batch.commit();
    } catch (err) {
      print('---===insertUsers - $err');
    }
  }

  Future<void> insertPosterImages(List<PosterNormalized> posters) async {
    Batch batch = db.batch();

    try {
      posters.where((poster) => poster.images.isNotEmpty).forEach((poster) {
        poster.images.forEach((image) => batch.insert(
              PosterImagesTable.name,
              poster.toJson()
                ..addEntries(
                    [MapEntry(PosterImagesTable.colPosterId, poster.id)]),
              conflictAlgorithm: ConflictAlgorithm.replace,
            ));
      });

      return batch.commit();
    } catch (err) {
      print('---===insertPosterImages - $err');
    }
  }

  Future<List<Map<String, dynamic>>> getPosters() async {
    try {
      return db.query(PostersTable.name);
    } catch (err) {
      print('---===getPosters - $err');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      return db.query(UsersTable.name);
    } catch (err) {
      print('---===getUsers - $err');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getPosterImages() async {
    try {
      return db.query(PosterImagesTable.name);
    } catch (err) {
      print('---===getPosterImages - $err');
      return null;
    }
  }
}
