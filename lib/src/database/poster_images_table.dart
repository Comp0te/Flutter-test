abstract class PosterImagesTable {
  static final name = 'poster_images';

  static final colPosterImageId = 'poster_image_id';
  static final colAdvert = 'advert';
  static final colFile = 'file';

  static final create = '''CREATE TABLE ${name}(
        ${colPosterImageId} INTEGER PRIMARY KEY,
        ${colAdvert} TEXT,
        ${colFile} TEXT,
        )''';
}
