import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
  brightness: Brightness.light,
  primary: Colors.grey.shade200,
  secondary: Colors.grey.shade400,
));

ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
  brightness: Brightness.dark,
  primary: Colors.grey.shade800,
  secondary: Colors.grey.shade600,
));
