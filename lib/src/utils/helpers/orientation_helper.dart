import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class OrientationHelper {
  static bool isLandscape(Orientation orientation) {
    return orientation == Orientation.landscape;
  }

  static bool isPortrait(Orientation orientation) {
    return orientation == Orientation.portrait;
  }

  static void setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void setOnlyPortraitUP() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
