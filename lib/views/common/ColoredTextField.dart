import 'package:counter/model/ColorPalette.dart';
import 'package:flutter/material.dart';

// default - dark
final _textColorDefault = Color(0xff000000);
final _decorationColorDefault = Color(0xffffffff);
// light
final _textColorForLight = Color(0xffffffff);
final _decorationColorForLight = Color(0xff212121);
//

class ColoredTextField extends StatelessWidget {
  const ColoredTextField(
    this.title, {
    Key key,
    this.decorationColor,
    this.textColor,
  }) : super(key: key);

  ColoredTextField.forLight(String title)
      : this(
          title,
          decorationColor: _decorationColorForLight,
          textColor: _textColorForLight,
        );

  ColoredTextField.justColor(int color)
      : this(
          "",
          decorationColor: ColorPalette.bgColor(color),
        );

  final String title;
  final Color decorationColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: title);
    return Container(
      decoration: BoxDecoration(
        color: decorationColor ?? _decorationColorDefault,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: textColor ?? _textColorDefault),
        textAlign: TextAlign.center,
      ),
    );
  }
}
