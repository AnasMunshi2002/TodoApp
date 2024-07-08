import 'package:flutter/material.dart';

class Themes {
  ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.grey.shade200,
    onPrimary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    onSecondary: Colors.grey.shade400,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: Colors.white,
  ));

  ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.grey.shade800,
    onPrimary: Colors.grey.shade800,
    secondary: Colors.grey.shade600,
    onSecondary: Colors.grey.shade600,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: Colors.white,
  ));
}
