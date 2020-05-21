import 'package:counter/widgets/color_picker/ColorPicker.dart';
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
    Color(0xFF2196F3),
    Color(0xFFF44336),
    Color(0xffff8f00),
    Color(0xff2e7d32),
    Color(0xffc2185b),
    Color(0xff795548),
    Color(0xff00796b),
    Color(0xff6a1b9a),
    Color(0xff546e7a),
  ];

  static const _dark_palette = [
    Color(0xFF42A5F5),
    Color(0xFFEF5350),
    Color(0xffFFA000),
    Color(0xff388E3C),
    Color(0xffD81B60),
    Color(0xff8D6E63),
    Color(0xff00897B),
    Color(0xff7B1FA2),
    Color(0xff607D8B),
  ];

  /// Used in [ColorPicker] to display available colors
  static const intPallete = [blue, red, yellow, green, pink, brown, teal, purple, blueGray];

  static Color color(int value) => palette[value];

  static Color darker(int value) => _dark_palette[value];
}
