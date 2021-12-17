import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Colors.purple;
Color primaryVariant = Colors.purple[800]!;
const Color secondary = Colors.purpleAccent;
Color secondaryVariant = Colors.purpleAccent[700]!;
Color surface = Colors.purple[100]!;
const Color background = Colors.white;
const Color onPrimary = Colors.white;
const Color onSecondary = Colors.white;
const Color onSurface = Colors.black;
const Color onBackground = Colors.black;
Color error = Colors.red[100]!;
Color onError = Colors.red[500]!;

final ThemeData appDarkThemeData = ThemeData.dark();

final ThemeData appLightThemeData = ThemeData.from(colorScheme: ColorScheme(
  primary: primary,
  primaryVariant: primaryVariant,
  secondary: secondary,
  secondaryVariant: secondaryVariant,
  surface: surface,
  background:  background,
  onPrimary: onPrimary,
  onSecondary: onSecondary,
  onSurface: onSurface,
  onBackground: onBackground,
  error: error,
  onError: onError,
  brightness: Brightness.light,
));

TextStyle subHeadingStyle () {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400]: Colors.grey,
    ),
  );
}

TextStyle headingStyle () {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24, 
      fontWeight: FontWeight.bold
    ),
  );
}

TextStyle titleStyle () {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 15, 
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle subTitleStyle () {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 13, 
      fontWeight: FontWeight.w400,
    ),
  );
}
