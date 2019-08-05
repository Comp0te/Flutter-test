import 'dart:io' as io;
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraProvider {
  static final String photoDir = 'pictures';
  static final String videoDir = 'video';

  Future<String> get _directoryPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  String get _timestamp => DateTime.now().millisecondsSinceEpoch.toString();

  String _getFilePath(
    String dirPath,
    String extension,
  ) =>
      join(dirPath, '$_timestamp.$extension');

  Future<String> takePicture(
      {@required CameraController cameraController}) async {
    if (!cameraController.value.isInitialized) {
      return null;
    }

    final photoDirPath = join(await _directoryPath, photoDir);

    await io.Directory(photoDirPath).create(recursive: true);

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    final photoPath = _getFilePath(photoDirPath, 'jpg');

    try {
      await cameraController.takePicture(photoPath);
    } on CameraException catch (e) {
      print('take photo exeption ---- $e');
      return null;
    }

    return photoPath;
  }

  Future<String> startRecordingVideo({
    @required CameraController cameraController,
  }) async {
    if (!cameraController.value.isInitialized) {
      return null;
    }

    final videoDirPath = join(await _directoryPath, videoDir);

    await io.Directory(videoDirPath).create(recursive: true);

    if (cameraController.value.isRecordingVideo) {
      return null;
    }

    final videoPath = _getFilePath(videoDirPath, 'mp4');

    try {
      await cameraController.startVideoRecording(videoPath);
    } on CameraException catch (e) {
      print('start recording video exeption ---- $e');
      return null;
    }

    return videoPath;
  }

  Future<void> stopRecordingVideo({
    @required CameraController cameraController,
  }) async {
    if (!cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      print('stop recording video exeption ---- $e');
      return;
    }
  }

  Future<void> deleteFile({@required String path}) async {
    final file = await io.File(path);
    await file.delete();
  }
}
