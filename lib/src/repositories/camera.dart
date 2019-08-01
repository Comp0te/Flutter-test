import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';

class CameraRepository {
  final CameraProvider _cameraProvider;

  CameraRepository({@required CameraProvider cameraProvider})
      : assert(cameraProvider != null),
        _cameraProvider = cameraProvider;

  Future<String> takePicture() async {
    return _cameraProvider.takePicture();
  }
}
