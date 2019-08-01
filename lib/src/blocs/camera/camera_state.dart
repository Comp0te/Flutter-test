import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class CameraState extends EquatableClass {
  final List<CameraDescription> cameras;
  final CameraController cameraController;
  final bool isAudioEnabled;

  CameraState({
    @required this.cameras,
    this.cameraController,
    this.isAudioEnabled,
  }) : super([cameras, cameraController, isAudioEnabled]);

  factory CameraState.init() => CameraState(
        cameras: [],
        cameraController: null,
        isAudioEnabled: true,
      );

  CameraState update({
    List<CameraDescription> cameras,
    CameraController cameraController,
    bool isAudioEnabled,
  }) {
    return CameraState(
      cameras: cameras ?? this.cameras,
      cameraController: cameraController ?? this.cameraController,
      isAudioEnabled: isAudioEnabled ?? this.isAudioEnabled,
    );
  }
}
