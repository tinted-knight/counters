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
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 16.0, 4.0),
      decoration: neuOuterDecoration,
      child: Center(
        child: Text(
          "$roadToGoal%\n of goal",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0, color: Color(0xff313131)),
        ),
      ),
    );
  }
}
