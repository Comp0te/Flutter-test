import 'dart:io' as io;
import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class ImageStoreRepository {
  final ImageStoreProvider _imageStoreProvider;

  ImageStoreRepository({
    @required ImageStoreProvider imageStoreProvider,
  })  : assert(imageStoreProvider != null),
        _imageStoreProvider = imageStoreProvider;

  Future<io.File> getImage(String url) async {
    return _imageStoreProvider.getImage(url);
  }

  Future<void> saveImage(String url) async {
    return _imageStoreProvider.saveImage(url: url);
  }
}
