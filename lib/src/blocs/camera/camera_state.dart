import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class CameraState extends EquatableClass {
  final List<CameraDescription> cameras;
  final CameraController cameraController;
  final bool isAudioEnabled;
  final String photoPath;
  final String videoPath;

  CameraState({
    @required this.cameras,
    this.cameraController,
    this.isAudioEnabled,
    this.photoPath,
    this.videoPath,
  }) : super([
          cameras,
          cameraController,
          isAudioEnabled,
          photoPath,
          videoPath,
        ]);

  factory CameraState.init() => CameraState(
        cameras: [],
        isAudioEnabled: true,
      );

  CameraState update({
    List<CameraDescription> cameras,
    CameraController cameraController,
    bool isAudioEnabled,
    String photoPath,
    String videoPath,
  }) {
    return CameraState(
      cameras: cameras ?? this.cameras,
      cameraController: cameraController ?? this.cameraController,
      isAudioEnabled: isAudioEnabled ?? this.isAudioEnabled,
      photoPath: photoPath ?? this.photoPath,
      videoPath: videoPath ?? this.videoPath,
    );
  }
}
