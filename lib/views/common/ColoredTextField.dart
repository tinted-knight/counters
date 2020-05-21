import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// default - dark
const _textColorDefault = Color(0xff313131);
// light
final _decorationColorForLight = Color(0xff212121);
//

typedef ChangeListener = Function(String);

class ColoredTextField extends StatelessWidget {
  const ColoredTextField({
    this.title,
    Key key,
    this.decorationColor,
    this.textColor,
    this.onlyDigits = false,
    @required this.controller,
    this.textAlign,
  }) : super(key: key);

  //!deprecated looks like easy to refactor to get rid of [ColoredTextField.forLight()]
  ColoredTextField.forLight(
      {String title = "", TextEditingController controller, bool onlyDigits, Color textColor})
      : this(
          title: title,
          decorationColor: _decorationColorForLight,
          controller: controller,
          onlyDigits: onlyDigits,
          textColor: textColor,
        );

  final String title;
  final Color decorationColor;
  final Color textColor;
  final bool onlyDigits;
  final TextAlign textAlign;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _neumorphicInnerDecoration,
      child: TextField(
        keyboardType: onlyDigits ? TextInputType.number : TextInputType.text,
        controller: controller,
        style: TextStyle(color: textColor ?? _textColorDefault),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }

  BoxDecoration get _neumorphicInnerDecoration => BoxDecoration(
        color: Colors.black.withOpacity(0.075),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(1, 1),
            blurRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );
}
