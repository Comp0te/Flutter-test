import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CameraEvent extends Equatable {
  CameraEvent([List props = const []]) : super(props);
}

class InitCamera extends CameraEvent {}

class ToggleCameraAudio extends CameraEvent {}

class SelectCamera extends CameraEvent {
  final CameraDescription cameraDescription;

  SelectCamera({this.cameraDescription}) : super([cameraDescription]);
}

class TakePicture extends CameraEvent {}

class StartVideoRecording extends CameraEvent {}

class StopVideoRecording extends CameraEvent {}

class DeleteCameraFile extends CameraEvent {
  final String path;

  DeleteCameraFile({@required this.path}) : super([path]);
}

class ResetCameraFiles extends CameraEvent {}
