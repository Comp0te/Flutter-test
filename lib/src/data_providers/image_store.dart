import 'dart:io' as Io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart';

class ImagesStoreProvider {
  Future<String> get _directoryPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  String getFileName(String url) {
    final urlArray = url.split('/');

    return urlArray[urlArray.length - 1];
  }

  Future<Io.File> getImage(String url) async {
    return Io.File(join(await _directoryPath, getFileName(url)));
  }

  Future<Io.File> getImageFromNetwork(String url) async {
    return DefaultCacheManager().getSingleFile(url);
  }

  Future<Io.File> saveImage(String url) async {
    final imageFromNetwork = await getImageFromNetwork(url);
    final decodedImage = decodeImage(await imageFromNetwork.readAsBytes());
    final image = await getImage(url);

    return image.writeAsBytes(encodeJpg(decodedImage));
  }
}
