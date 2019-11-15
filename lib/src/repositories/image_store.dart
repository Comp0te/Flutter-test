import 'dart:io' as io;
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

class ImageStoreRepository implements ImageDatabaseRepository {
  @override
  final ImageDatabaseProvider imageDatabaseProvider;

  ImageStoreRepository({
    @required this.imageDatabaseProvider,
  }) : assert(imageDatabaseProvider != null);

  @override
  Future<io.File> getImage(String url) async {
    return imageDatabaseProvider.getImage(url);
  }

  @override
  Future<void> saveImage(String url) async {
    return imageDatabaseProvider.computeSaveImage(url);
  }
}
