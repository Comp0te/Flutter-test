import 'package:flutter/material.dart';

mixin ThemeMixin on Widget {
  ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }

  ColorScheme getColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  TextTheme getTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  TextTheme getPrimaryTextTheme(BuildContext context) {
    return Theme.of(context).primaryTextTheme;
  }

  TextTheme getAccentTextTheme(BuildContext context) {
    return Theme.of(context).accentTextTheme;
  }
}
