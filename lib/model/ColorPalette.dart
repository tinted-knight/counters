import 'package:flutter/material.dart';

class ColorPalette {
  ColorPalette._();

  static const _blue = Color(0xff2C98F0);
  static const _red = Color(0xffFF5722);
  static const _yellow = Color(0xffFFC107);

  static const _bgBlue = Color(0xff2C98F0);
  static const _bgRed = Color(0xffFF5722);
  static const _bgYellow = Color(0xffFFC107);
//  static const _bgBlue = Color(0xff0D47A1);
//  static const _bgRed = Color(0xffBF360C);
//  static const _bgYellow = Color(0xffF57F17);

  static const blue = 0;
  static const red = 1;
  static const yellow = 2;

  static const _palette = [_blue, _red, _yellow];

  static const _bgPalette = [_bgBlue, _bgRed, _bgYellow];

  static Color color(int value) => _palette[value];

  static Color bgColor(int value) => _bgPalette[value];
}

final colors = {"blue": Color(0xff2C98F0)};
