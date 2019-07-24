import 'dart:async';
import 'dart:io';
import 'package:flutter_app/src/database/owners_table.dart';
import 'package:flutter_app/src/database/poster_images_table.dart';
import 'package:flutter_app/src/database/posters_table.dart';
import 'package:flutter_app/src/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    try {
      _db = await _initDb();

      print('-------- db created success ${_db.toString()}');
    } catch (err) {
      print('=======db error===== $err');
    }
    return _db;
  }

  Future<Database> _initDb() async {
    String databasesPath = await getDatabasesPath();

    bool isDbDirExist = await Directory(databasesPath).exists();

    if (!isDbDirExist) {
      await Directory(databasesPath).create(recursive: true);
    }

    String path = join(databasesPath, DbConfig.dbName);

    return await openDatabase(
      path,
      version: DbConfig.dbVersion,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db
        .execute(PostersTable.create)
        .whenComplete(() => print('---------------- posters table created'));
    await db
        .execute(OwnersTable.create)
        .whenComplete(() => print('---------------- owners table created'));
    await db
        .execute(PosterImagesTable.create)
        .whenComplete(() => print('---------------- images table created'));
  }
}
