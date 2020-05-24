import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeLight {
  ThemeLight._();

  static const primary = Color(0xff212121);
  static const iconPrimary = Color(0xff414141);
  static const iconReverse = Color(0xff00ff00);
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
      iconTheme: _buildIconTheme(baseTheme),
      primaryIconTheme: _buildIconTheme(baseTheme),
      inputDecorationTheme: _buildInputDecorationTheme(baseTheme),
// !note back gesture on Cupertino transition does not work with WillPopSope widget
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      }),
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

_buildIconTheme(ThemeData baseTheme) {
  return baseTheme.iconTheme.copyWith(
    color: ThemeLight.iconPrimary,
  );
}

const appBarBgImages = [
  "top03.png",
  "top04.png",
];
