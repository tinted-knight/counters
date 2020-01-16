import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static const primary = Color(0xff212121);
  static const accent = Color(0xffFF5722);
}

var themeDark = ThemeData(
  primaryColor: ThemeColors.primary,
  accentColor: ThemeColors.accent,
);
