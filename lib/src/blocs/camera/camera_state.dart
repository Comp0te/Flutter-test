import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class CameraState extends EquatableClass {
  final List<CameraDescription> cameras;
  final CameraController cameraController;
  final bool isAudioEnabled;
  final bool isVideoRecording;
  final String photoPath;
  final String videoPath;

  bool get isInitialized =>
      cameraController != null && cameraController.value.isInitialized;

  CameraState({
    @required this.cameras,
    this.cameraController,
    this.isAudioEnabled,
    this.isVideoRecording,
    this.photoPath,
    this.videoPath,
  }) : super([
          cameras,
          cameraController,
          isAudioEnabled,
          isVideoRecording,
          photoPath,
          videoPath,
        ]);

  factory CameraState.init() => CameraState(
        cameras: [],
        isAudioEnabled: true,
        isVideoRecording: false,
      );

  CameraState copyWith({
    List<CameraDescription> cameras,
    CameraController cameraController,
    bool isAudioEnabled,
    bool isVideoRecording,
    String photoPath,
    String videoPath,
  }) {
    return CameraState(
      cameras: cameras ?? this.cameras,
      cameraController: cameraController ?? this.cameraController,
      isAudioEnabled: isAudioEnabled ?? this.isAudioEnabled,
      isVideoRecording: isVideoRecording ?? this.isVideoRecording,
      photoPath: photoPath ?? this.photoPath,
      videoPath: videoPath ?? this.videoPath,
    );
  }

  CameraState resetCameraFiles() {
    return CameraState(
      cameras: cameras,
      cameraController: cameraController,
      isAudioEnabled: isAudioEnabled,
      isVideoRecording: isVideoRecording,
      photoPath: null,
      videoPath: null,
    );
  }
}
