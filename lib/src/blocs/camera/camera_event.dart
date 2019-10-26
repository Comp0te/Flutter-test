import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class InitCamera extends CameraEvent {
  @override
  List<Object> get props => [];
}

class ToggleCameraAudio extends CameraEvent {
  @override
  List<Object> get props => [];
}

class SelectCamera extends CameraEvent {
  final CameraDescription cameraDescription;

  SelectCamera({this.cameraDescription});

  @override
  List<Object> get props => [cameraDescription];
}

class TakePicture extends CameraEvent {
  @override
  List<Object> get props => [];
}

class StartVideoRecording extends CameraEvent {
  @override
  List<Object> get props => [];
}

class StopVideoRecording extends CameraEvent {
  @override
  List<Object> get props => [];
}

class DeleteCameraFile extends CameraEvent {
  final String path;

  DeleteCameraFile({@required this.path});

  @override
  List<Object> get props => [path];
}

class ResetCameraFiles extends CameraEvent {
  @override
  List<Object> get props => [];
}
