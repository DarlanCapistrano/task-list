// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ColorsApp{
  static ColorTheme colorAppTheme = ColorTheme.white;
  static Color dialogColor = Colors.white;
  static Color primaryColor = Colors.white;
  static Color secondaryColor = Colors.black;
  static Color tertiaryColor = Colors.grey[600]!;
  static Color widgetsColor = Colors.red;

  static void chooseAppTheme(ColorTheme theme){
    switch(theme){
      case ColorTheme.white:
        colorAppTheme = ColorTheme.white;
        dialogColor = Colors.white;
        primaryColor = Colors.white;
        secondaryColor = Colors.black;
        tertiaryColor = Colors.grey[600]!;
      break;
      case ColorTheme.dark:
        colorAppTheme = ColorTheme.dark;
        dialogColor = Color(0xFF3D3A3A);
        primaryColor = Color(0xFF212121);
        secondaryColor = Colors.white;
        tertiaryColor = Colors.white;
      break;
      default:
    }
  }
}

enum ColorTheme {
  dark,
  white,
}