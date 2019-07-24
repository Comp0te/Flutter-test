import 'package:flutter_app/src/database/tables/posters_table.dart';

abstract class PosterImagesTable {
  static final name = 'poster_images';

  static final colPosterImageId = 'poster_image_id';
  static final colAdvert = 'advert';
  static final colFile = 'file';
  static final colPosterId = 'poster_id';

  static final create = '''CREATE TABLE ${name}(
        ${colPosterImageId} INTEGER PRIMARY KEY,
        ${colAdvert} TEXT,
        ${colFile} TEXT,
        ${colPosterId} INTEGER,
        FOREIGN KEY (${colPosterId}) 
        REFERENCES ${PostersTable.name}(${PostersTable.colPosterId})
        )''';
}
