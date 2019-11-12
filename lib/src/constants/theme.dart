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
);

final darkTheme = ThemeData.from(
  colorScheme: darkColorScheme,
  textTheme: textDarkTheme,
);
