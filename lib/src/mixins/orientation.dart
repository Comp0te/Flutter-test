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

  BoxConstraints getMaxWidthConstraints(
    BuildContext context,
    num partOfMaxWidth,
  ) {
    assert(partOfMaxWidth >= 0 && partOfMaxWidth <= 1);

    return isLandscape(context)
        ? BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * partOfMaxWidth,
          )
        : const BoxConstraints();
  }
}
