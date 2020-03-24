import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

const _kOffset = 2.0;
const _kBlur = 2.0;
const _kShadowLight = Color(0xAAFFFFFF);
const _kShadowDark = Color(0xAAD1CDC7);

class RoadToGoal extends StatelessWidget {
  const RoadToGoal(
    this.roadToGoal, {
    Key key,
  }) : super(key: key);

  final int roadToGoal;

  final _red = const Color(0xFFffcdd2);
  final _green = const Color(0xFFc8e6c9);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 16.0, 4.0),
      decoration: _neumorphicDecoration,
      child: Center(
        child: Text(
          "$roadToGoal%\n of goal",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0, color: Color(0xff313131)),
        ),
      ),
    );
  }

  /// @deprecated
  BoxDecoration get _redToGreen => BoxDecoration(
        color: roadToGoal >= 100 ? _green : _red,
        borderRadius: BorderRadius.circular(4.0),
      );

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
}
