import 'package:flutter/material.dart';

const firaSansFontFamily = 'FiraSans';

final textLightTheme = Typography.englishLike2018.apply(
  fontFamily: firaSansFontFamily,
);

final textDarkTheme = Typography.englishLike2018.apply(
  fontFamily: firaSansFontFamily,
);

const lightColorScheme = ColorScheme.light();
const darkColorScheme = ColorScheme.dark();

final lightTheme = ThemeData.from(
  colorScheme: lightColorScheme,
  textTheme: textLightTheme,
).copyWith(
  primaryTextTheme: textLightTheme,
  accentTextTheme: textLightTheme,
);

final darkTheme = ThemeData.from(
  colorScheme: darkColorScheme,
  textTheme: textDarkTheme,
).copyWith(
  primaryTextTheme: textDarkTheme,
  accentTextTheme: textDarkTheme,
);

const invertFilterMatrix = <double>[
  //R  G   B    A  Const
  -1, 0, 0, 0, 255, //
  0, -1, 0, 0, 255, //
  0, 0, -1, 0, 255, //
  0, 0, 0, 1, 0, //
];
