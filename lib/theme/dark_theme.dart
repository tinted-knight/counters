import 'package:flutter/material.dart';

class ThemeLight {
  ThemeLight._();

  static const primary = Color(0xff212121);

//  static const accent = Color(0xff757575);
//  static const accent = Colors.deepOrangeAccent;
//  static const accent = Color(0xff313131);
  static const accent = Color(0xFFFFFFFF);
  static const scaffoldBgColor = Color(0xFFEFEEEE);
  static const button = Color(0xff00796b);
  static const appbarColor = Color(0xFFEFEEEE);
}

var themeLight = _buildThemeData(ThemeData());

_buildThemeData(ThemeData baseTheme) => baseTheme.copyWith(
      primaryColor: ThemeLight.primary,
      accentColor: ThemeLight.accent,
      scaffoldBackgroundColor: ThemeLight.scaffoldBgColor,
      buttonTheme: _buildButtonTheme(baseTheme),
      floatingActionButtonTheme: _buildFabTheme(baseTheme),
      inputDecorationTheme: _buildInputDecorationTheme(baseTheme),
// @note back gesture on Cupertino transition does not work with WillPopSope widget
//      pageTransitionsTheme: PageTransitionsTheme(builders: {
//        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//      }),
    );

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

const appBarBgImages = [
  "pixeal_heart.png",
  "canadian_dollar.png",
  "let_there_be_sun.png",
];
