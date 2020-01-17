import 'package:flutter/material.dart';

class ThemeLight {
  ThemeLight._();

  static const primary = Color(0xff212121);
  static const accent = Color(0xffFF5722);
}

var themeDark = _buildThemeData(ThemeData());

_buildThemeData(ThemeData baseTheme) => baseTheme.copyWith(
      primaryColor: ThemeLight.primary,
      accentColor: ThemeLight.accent,
//      textTheme: _buildTextTheme(baseTheme),
      inputDecorationTheme: _buildInputDecorationTheme(baseTheme),
    );

//_buildTextTheme(ThemeData baseTheme) => baseTheme.textTheme.copyWith(
//      body1: TextStyle(color: Color(0xff000000)),
//    );

_buildInputDecorationTheme(ThemeData baseTheme) {
  return baseTheme.inputDecorationTheme.copyWith(
    border: InputBorder.none,
    contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
  );
}
