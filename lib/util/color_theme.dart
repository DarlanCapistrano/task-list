import 'package:flutter/material.dart';

class ColorsApp{
  static ColorTheme colorAppTheme = ColorTheme.white;
  final Color primaryColor = colorAppTheme == ColorTheme.white ? Colors.white : Colors.black;
}

enum ColorTheme {
  dark,
  white,
}