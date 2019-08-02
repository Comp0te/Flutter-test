import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

// don't extends EquatableClass in order to regularly update state by reference
@immutable
class CameraState {
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
  });

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
