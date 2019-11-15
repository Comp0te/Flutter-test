import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

enum CameraErrorType { unavailable, common }

@immutable
class CameraState extends EquatableClass {
  static final defaultResolutionPreset = ResolutionPreset.high;
  static final defaultEnableAudio = true;

  final List<CameraDescription> cameras;
  final CameraController cameraController;
  final bool isAudioEnabled;
  final bool isVideoRecording;
  final String photoPath;
  final String videoPath;
  final CameraErrorType errorType;

  bool get isInitialized =>
      cameraController != null && cameraController.value.isInitialized;
  bool get hasError => errorType != null;
  bool get hasPhotoPath => photoPath != null;
  bool get hasVideoPath => videoPath != null;

  CameraState({
    @required this.cameras,
    this.cameraController,
    this.isAudioEnabled,
    this.isVideoRecording,
    this.photoPath,
    this.videoPath,
    this.errorType,
  });

  factory CameraState.init() => CameraState(
        cameras: [],
        isAudioEnabled: true,
        isVideoRecording: false,
      );

  CameraState copyWith(
      {List<CameraDescription> cameras,
      CameraController cameraController,
      bool isAudioEnabled,
      bool isVideoRecording,
      String photoPath,
      String videoPath,
      CameraErrorType errorType}) {
    return CameraState(
      cameras: cameras ?? this.cameras,
      cameraController: cameraController ?? this.cameraController,
      isAudioEnabled: isAudioEnabled ?? this.isAudioEnabled,
      isVideoRecording: isVideoRecording ?? this.isVideoRecording,
      photoPath: photoPath ?? this.photoPath,
      videoPath: videoPath ?? this.videoPath,
      errorType: errorType ?? this.errorType,
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
      errorType: null,
    );
  }

  @override
  List<Object> get props => [
        cameras,
        cameraController,
        isAudioEnabled,
        isVideoRecording,
        photoPath,
        videoPath,
        errorType,
      ];
}
