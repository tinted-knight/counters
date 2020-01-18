import 'package:flutter/material.dart';

// default - dark
const _kTextLabelBg = Color(0xff212121);
const _kTextColor = Color(0xffffffff);
//light
const _kTextLabelBgForLight = Color(0x00ffffff);
const _kTextColorForLight = Color(0xff212121);

class ColoredTextLabel extends StatelessWidget {
  const ColoredTextLabel(
    this.title, {
    this.textLabelBg,
    this.textColor,
    Key key,
  }) : super(key: key);

  const ColoredTextLabel.forDark(String title) : this(title);

  const ColoredTextLabel.forLight(String title)
      : this(
          title,
          textLabelBg: _kTextLabelBgForLight,
          textColor: _kTextColorForLight,
        );

  final String title;
  final Color textLabelBg;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textLabelBg ?? _kTextLabelBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(color: textColor ?? _kTextColor),
      ),
    );
  }
}
