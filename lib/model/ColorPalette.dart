import 'package:flutter/material.dart';

class ColorPalette {
  ColorPalette._();

  static const blue = 0;
  static const red = 1;
  static const yellow = 2;
  static const green = 3;
  static const brown = 4;
  static const pink = 5;
  static const teal = 6;
  static const purple = 7;
  static const blueGray = 8;

  static const defaultColor = blue;

  static const palette = [
    Color(0xff2C98F0),
    Color(0xffFF5722),
    Color(0xffff8f00),
    Color(0xff2e7d32),
    Color(0xffc2185b),
    Color(0xff795548),
    Color(0xff00796b),
    Color(0xff6a1b9a),
    Color(0xff546e7a),
  ];

  static const intPallete = [blue, red, yellow, green, pink, brown, teal, purple, blueGray];

  static Color color(int value) => palette[value];

  /// @deprecated -> [color]
  static Color bgColor(int value) => palette[value];
}

final colors = {"blue": Color(0xff2C98F0)};
