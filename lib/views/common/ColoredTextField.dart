import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _textColorDefault = Color(0xff313131);
const _decorationColorForLight = Color(0xff212121);

class ColoredTextField extends StatelessWidget {
  const ColoredTextField({
    this.title,
    Key key,
    this.decorationColor = _decorationColorForLight,
    this.textColor,
    this.onlyDigits = false,
    @required this.controller,
    this.textAlign,
    this.autoFocus = false,
  }) : super(key: key);

  final String title;
  final Color decorationColor;
  final Color textColor;
  final bool onlyDigits;
  final TextAlign textAlign;
  final bool autoFocus;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: neuInnerDecoration,
      child: TextField(
        autofocus: autoFocus,
        keyboardType: onlyDigits ? TextInputType.number : TextInputType.text,
        controller: controller,
        style: TextStyle(color: textColor ?? _textColorDefault),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
