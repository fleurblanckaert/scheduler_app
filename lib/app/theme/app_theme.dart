import 'package:flutter/material.dart';

final ThemeData appDarkThemeData = ThemeData.dark();

final ThemeData appLightThemeData = ThemeData.from(colorScheme: ColorScheme(
  primary: Colors.purple,
  primaryVariant: Colors.purple[800]!,
  secondary: Colors.purpleAccent,
  secondaryVariant: Colors.purpleAccent[700]!,
  surface: Colors.purple[100]!,
  background:  Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  onBackground: Colors.black,
  error: Colors.red[100]!,
  onError: Colors.red[500]!,
  brightness: Brightness.light,
));
