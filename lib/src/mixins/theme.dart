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

  Color getContrastTextColor(BuildContext context) {
    return getTheme(context).brightness == Brightness.dark
        ? getColorScheme(context).onBackground
        : getColorScheme(context).onPrimary;
  }
}
