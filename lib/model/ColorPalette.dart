import 'package:flutter/material.dart';

class ColorPalette {
  ColorPalette._();

  static const _blue = Color(0xff2C98F0);
  static const _red = Color(0xffFF5722);
  static const _yellow = Color(0xffff8f00);

  static const blue = 0;
  static const red = 1;
  static const yellow = 2;

  static const defaultColor = blue;

  static const palette = [_blue, _red, _yellow];

  static Color color(int value) => palette[value];

  static Color bgColor(int value) => palette[value];
}

final colors = {"blue": Color(0xff2C98F0)};
