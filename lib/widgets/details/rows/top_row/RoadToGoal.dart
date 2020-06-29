import 'package:counter/i18n/app_localization.dart';
import 'package:counter/theme/light_theme.dart';
import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:flutter/material.dart';

class RoadToGoal extends StatelessWidget {
  const RoadToGoal(
    this.roadToGoal, {
    Key key,
  }) : super(key: key);

  final int roadToGoal;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalization.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 16.0, 4.0),
      decoration: neuOuterDecoration,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/flor.png",
              isAntiAlias: true,
              color: ThemeLight.scaffoldBgColor.withOpacity(.6),
              colorBlendMode: BlendMode.lighten,
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Text(
              "$roadToGoal%\n ${locale.ofGoal}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, color: Color(0xff313131)),
            ),
          ),
        ],
      ),
    );
  }
}
