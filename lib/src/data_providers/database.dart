import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/databases/sqflite/tables/tables.dart';
import 'package:flutter_app/src/models/model.dart';

class SQFLiteProvider implements DatabaseProvider {
  final Future<Database> db;

  SQFLiteProvider({
    @required this.db,
  }) : assert(db != null);

  @override
  Future<void> insertPosters(List<PosterNormalized> posters) async {
    final _db = await db;
    final batch = _db.batch();

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

  @override
  Future<void> insertUsers(List<User> users) async {
    final _db = await db;
    final batch = _db.batch();

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

  @override
  Future<void> insertPosterImages(List<PosterNormalized> posters) async {
    final _db = await db;
    final batch = _db.batch();

    try {
      final imagesDb = posters.fold<List<PosterImageDB>>(
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

  @override
  Future<List<Map<String, dynamic>>> getPosters() async {
    final _db = await db;

    try {
      return _db.query(PostersTable.name);
    } catch (err) {
      print('---===getPosters - $err');
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUsers() async {
    final _db = await db;

    try {
      return _db.query(UsersTable.name);
    } catch (err) {
      print('---===getUsers - $err');
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPosterImages() async {
    final _db = await db;

    try {
      return _db.query(PosterImagesTable.name);
    } catch (err) {
      print('---===getPosterImages - $err');
      return null;
    }
  }
}
