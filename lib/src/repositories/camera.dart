import 'dart:async';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class CameraRepository {
  final CameraProvider _cameraProvider;

  CameraRepository({@required CameraProvider cameraProvider})
      : assert(cameraProvider != null),
        _cameraProvider = cameraProvider;

  Future<String> takePicture(CameraController cameraController) async {
    return _cameraProvider.takePicture(
      cameraController: cameraController,
    );
  }

  Future<String> startRecordingVideo(CameraController cameraController) async {
    return _cameraProvider.startRecordingVideo(
      cameraController: cameraController,
    );
  }

  Future<void> stopRecordingVideo(CameraController cameraController) async {
    return _cameraProvider.stopRecordingVideo(
      cameraController: cameraController,
    );
  }

  Future<void> deleteFile({@required String path}) async {
     return _cameraProvider.deleteFile(path: path);
  }
}
