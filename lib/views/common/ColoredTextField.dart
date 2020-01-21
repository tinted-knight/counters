import 'package:counter/model/ColorPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// default - dark
final _textColorDefault = Color(0xff000000);
final _decorationColorDefault = Color(0xffffffff);
// light
final _textColorForLight = Color(0xffffffff);
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
  }) : super(key: key);

  ColoredTextField.forLight(
      {String title = "", TextEditingController controller, bool onlyDigits})
      : this(
          title: title,
          decorationColor: _decorationColorForLight,
          textColor: _textColorForLight,
          controller: controller,
          onlyDigits: onlyDigits,
        );

  ColoredTextField.justColor(int color)
      : this(
          title: "",
          decorationColor: ColorPalette.bgColor(color),
          controller: null,
        );

  final String title;
  final Color decorationColor;
  final Color textColor;
  final bool onlyDigits;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: decorationColor ?? _decorationColorDefault,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        keyboardType: onlyDigits ? TextInputType.number : TextInputType.text,
        controller: controller,
        style: TextStyle(color: textColor ?? _textColorDefault),
        textAlign: TextAlign.center,
      ),
    );
  }

///////////////////////////////////////////////////////////////////////
  _testBorder() {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Colors.green,
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );

    final underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white38,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 8.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: (text) {},
//        decoration: InputDecoration(
//          enabledBorder: underlineBorder,
//          focusedBorder: underlineBorder,
//        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
