import 'package:flutter/material.dart';

const firaSansFontFamily = 'Fira Sans';

final textLightTheme = const TextTheme().apply(
  fontFamily: firaSansFontFamily,
  bodyColor: Colors.black,
);

final textDarkTheme = const TextTheme().apply(
  fontFamily: firaSansFontFamily,
  bodyColor: Colors.white,
);

const lightColorScheme = ColorScheme.light();
const darkColorScheme = ColorScheme.dark();

final lightTheme = ThemeData.from(
  colorScheme: lightColorScheme,
  textTheme: textLightTheme,
);

final darkTheme = ThemeData.from(
  colorScheme: darkColorScheme,
  textTheme: textDarkTheme,
);
