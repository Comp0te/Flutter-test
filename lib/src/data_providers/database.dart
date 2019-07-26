import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../database/tables.dart';

class DBProvider {
  final Future<Database> db;

  DBProvider({
    @required this.db,
  }) : assert(db != null);

  Future<void> insertPosters(List<PosterNormalized> posters) async {
    Database _db = await db;
    Batch batch = _db.batch();

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
    Database _db = await db;
    Batch batch = _db.batch();

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
    Database _db = await db;
    Batch batch = _db.batch();

    try {
      List<PosterImageDB> imagesDb = posters.fold<List<PosterImageDB>>(
        [],
        (acc, poster) {
          if (poster.images != null && poster.images.isNotEmpty) {
            acc.addAll(
              poster.images
                  .map<PosterImageDB>((image) => PosterImageDB(
                      id: image.id,
                      advert: image.advert,
                      file: image.file,
                      posterId: poster.id))
                  .toList(),
            );
          }

          return acc;
        },
      );

      imagesDb.forEach((image) => batch.insert(
            PosterImagesTable.name,
            image.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          ));

      return batch.commit();
    } catch (err) {
      print('---===insertPosterImages - $err');
    }
  }

  Future<List<Map<String, dynamic>>> getPosters() async {
    Database _db = await db;

    try {
      return _db.query(PostersTable.name);
    } catch (err) {
      print('---===getPosters - $err');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database _db = await db;

    try {
      return _db.query(UsersTable.name);
    } catch (err) {
      print('---===getUsers - $err');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getPosterImages() async {
    Database _db = await db;

    try {
      return _db.query(PosterImagesTable.name);
    } catch (err) {
      print('---===getPosterImages - $err');
      return null;
    }
  }
}
