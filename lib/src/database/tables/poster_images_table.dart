import 'package:flutter_app/src/database/tables/posters_table.dart';

abstract class PosterImagesTable {
  static final name = 'poster_images';

  static final colPosterImageId = 'pk';
  static final colAdvert = 'advert';
  static final colFile = 'file';
  static final colPosterId = 'posterId';

  static final create = '''CREATE TABLE $name(
        $colPosterImageId INTEGER PRIMARY KEY,
        $colAdvert INTEGER,
        $colFile TEXT,
        $colPosterId INTEGER,
        FOREIGN KEY ($colPosterId) 
        REFERENCES ${PostersTable.name}(${PostersTable.colPosterId})
        )''';
}
