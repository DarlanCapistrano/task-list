// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ColorsApp{
  static AppTheme colorAppTheme = AppTheme.white;
  static Color dialogColor = Colors.white;
  static Color primaryColor = Colors.white;
  static Color secondaryColor = Colors.black;
  static Color tertiaryColor = Colors.grey[600]!;
  static Color widgetsColor = Colors.red;

  static void chooseAppTheme(AppTheme theme){
    switch(theme){
      case AppTheme.white:
        colorAppTheme = AppTheme.white;
        dialogColor = Colors.white;
        primaryColor = Colors.white;
        secondaryColor = Colors.black;
        tertiaryColor = Colors.grey[600]!;
      break;
      case AppTheme.dark:
        colorAppTheme = AppTheme.dark;
        dialogColor = Color(0xFF3D3A3A);
        primaryColor = Color(0xFF212121);
        secondaryColor = Colors.white;
        tertiaryColor = Colors.white;
      break;
      default:
    }
  }
}

enum AppTheme {
  dark,
  white,
}