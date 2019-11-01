import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin OrientationMixin on Widget {
  bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  void setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void setOnlyPortraitUP() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
