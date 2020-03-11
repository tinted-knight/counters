import 'package:flutter/material.dart';

class ThemeLight {
  ThemeLight._();

  static const primary = Color(0xff212121);
  static const accent = Color(0xff757575);
  static const scaffoldBgColor = Color(0xFFEFEEEE);
  static const button = Color(0xff00796b);
}

var themeLight = _buildThemeData(ThemeData(
//  fontFamily: "RobotoCondensed",
    ));

_buildThemeData(ThemeData baseTheme) => baseTheme.copyWith(
    primaryColor: ThemeLight.primary,
    accentColor: ThemeLight.accent,
    scaffoldBackgroundColor: ThemeLight.scaffoldBgColor,
    buttonTheme: _buildButtonTheme(baseTheme),
    floatingActionButtonTheme: _buildFabTheme(baseTheme),
//      textTheme: _buildTextTheme(baseTheme),
    inputDecorationTheme: _buildInputDecorationTheme(baseTheme),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    textTheme: baseTheme.textTheme.copyWith(
      headline6: baseTheme.textTheme.headline6.copyWith(color: Color(0xffff0000)),
    ));

//_buildTextTheme(ThemeData baseTheme) => baseTheme.textTheme.copyWith(
//      body1: TextStyle(color: Color(0xff000000)),
//    );

_buildInputDecorationTheme(ThemeData baseTheme) {
  return baseTheme.inputDecorationTheme.copyWith(
    border: InputBorder.none,
    contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
  );
}

_buildButtonTheme(ThemeData baseTheme) {
  return baseTheme.buttonTheme.copyWith(
    buttonColor: ThemeLight.accent,
  );
}

_buildFabTheme(ThemeData baseTheme) {
  return baseTheme.floatingActionButtonTheme.copyWith(
    backgroundColor: ThemeLight.accent,
  );
}
