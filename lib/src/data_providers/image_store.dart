import 'dart:io' as io;
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart';

class ImageStoreProvider {
  Future<String> get _directoryPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  String _getFileName(String url) {
    final urlArray = url.split('/');

    return urlArray[urlArray.length - 1];
  }

  Future<io.File> getImageFile(String url) async {
    return io.File(join(await _directoryPath, _getFileName(url)));
  }

  Future<io.File> getImage(String url) async {
    final imageFile = await getImageFile(url);
    final bool isImageFileExist = await imageFile.exists();

    if (isImageFileExist) {
      return imageFile;
    }

    return null;
  }

  Future<io.File> fetchImageFromNetwork(String url) async {
    return DefaultCacheManager().getSingleFile(url);
  }

  Future<void> saveImage({
    @required String url,
  }) async {
    final imageFile = await getImageFile(url);
    final imageFromNetwork = await fetchImageFromNetwork(url);
    final decodedImage = decodeImage(await imageFromNetwork.readAsBytes());

    await imageFile.writeAsBytes(encodeJpg(decodedImage));
  }
}
