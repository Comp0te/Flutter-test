import 'dart:io' as Io;
import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class ImageStoreRepository {
  final ImagesStoreProvider _imagesStoreProvider;

  ImageStoreRepository({
    @required ImagesStoreProvider imagesStoreProvider,
  })  : assert(imagesStoreProvider != null),
        _imagesStoreProvider = imagesStoreProvider;

  Future<Io.File> getImage(String url) async {
    return _imagesStoreProvider.getImage(url);
  }

  Future<Io.File> getImageFromNetwork(String url) async {
    return _imagesStoreProvider.getImageFromNetwork(url);
  }

  Future<Io.File> saveImage(String url) async {
    return _imagesStoreProvider.saveImage(url);
  }
}
