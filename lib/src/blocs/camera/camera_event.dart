import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CameraEvent extends Equatable {
  CameraEvent([List props = const []]) : super(props);
}

class GetAvailableCameras extends CameraEvent {}
