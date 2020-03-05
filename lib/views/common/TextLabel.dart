import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

const _kTextLabelBg = Color(0xff212121);

const _kOffset = 2.0;
const _kBlur = 2.0;
const _kShadowLight = Color(0xAAFFFFFF);
const _kShadowDark = Color(0xAAD1CDC7);


class TextLabel extends StatelessWidget {
  const TextLabel(this.title, {Key key, this.centered = false}) : super(key: key);

  final String title;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _neumorphicDecoration,
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        textAlign: centered ? TextAlign.center : TextAlign.start,
      ),
    );
  }

  BoxDecoration get _neumorphicDecoration => BoxDecoration(
    color: ThemeLight.scaffoldBgColor,
    boxShadow: [
      // kind of neumorphism
      // top shadow - light
      BoxShadow(
        color: _kShadowLight,
        offset: Offset(-_kOffset, -_kOffset),
        blurRadius: _kBlur,
      ),
      // botttom shadow - dark
      BoxShadow(
        color: _kShadowDark,
        offset: Offset(_kOffset, _kOffset),
        blurRadius: _kBlur,
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  BoxDecoration get _darkDecoration =>
      BoxDecoration(
        color: _kTextLabelBg,
        borderRadius: BorderRadius.circular(8.0),
      );

}

class ExpandedLeft extends StatelessWidget {
  const ExpandedLeft({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
        child: child,
      ),
    );
  }
}
