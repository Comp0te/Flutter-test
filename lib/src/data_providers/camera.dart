import 'dart:io' as io;
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraProvider {
  static final String photoDir = 'pictures';

  Future<String> get _directoryPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  String get _timestamp => DateTime.now().millisecondsSinceEpoch.toString();

  String _getFilePath(String dirPath) => join(dirPath, '$_timestamp.jpg');

  Future<String> takePicture({@required CameraController cameraController}) async {
    if (!cameraController.value.isInitialized) {
      return null;
    }

    final photoDirPath = join(await _directoryPath, photoDir);

    await io.Directory(photoDirPath).create(recursive: true);

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    final photoPath = _getFilePath(photoDirPath);

    try {
      await cameraController.takePicture(photoPath);
    } on CameraException catch (e) {
      print('take photo exeption ---- $e');
      return null;
    }
    return photoPath;
  }
}
