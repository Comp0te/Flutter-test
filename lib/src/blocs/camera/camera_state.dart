import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class CameraState extends EquatableClass {
  final List<CameraDescription> cameras;

  CameraState({@required this.cameras})
      : super([cameras]);

  factory CameraState.init() =>
      CameraState(cameras: []);

  CameraState update({List<CameraDescription> cameras}) {
    return CameraState(cameras: cameras ?? this.cameras);
  }
}
