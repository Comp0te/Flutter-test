import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class InitCamera extends CameraEvent {}

class ToggleCameraAudio extends CameraEvent {}

class SelectCamera extends CameraEvent {
  final CameraDescription cameraDescription;

  const SelectCamera({this.cameraDescription});

  @override
  List<Object> get props => [cameraDescription];
}

class TakePicture extends CameraEvent {}

class StartVideoRecording extends CameraEvent {}

class StopVideoRecording extends CameraEvent {}

class DeleteCameraFile extends CameraEvent {
  final String path;

  const DeleteCameraFile({@required this.path});

  @override
  List<Object> get props => [path];
}

class ResetCameraFiles extends CameraEvent {}
