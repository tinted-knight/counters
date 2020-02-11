import 'package:counter/views/common/ColoredTextField.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
    this.value,
    this.goal,
    this.controller,
  }) : super(key: key);

  final int value;
  final int goal;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final roadToGoal = ((value / goal) * 100).floor();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ExpandedLeft(child: TextLabel("Today")),
              ExpandedLeft(
                  child: ColoredTextField(
                controller: controller,
                onlyDigits: true,
              )),
            ],
          ),
        ),
        Expanded(child: RoadToGoal(roadToGoal)),
      ],
    );
  }
}

class RoadToGoal extends StatelessWidget {
  const RoadToGoal(
    this.roadToGoal, {
    Key key,
  }) : super(key: key);

  final int roadToGoal;

  final _red = const Color(0xffF50057);
  final _green = const Color(0xff00E676);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 16.0, 4.0),
      decoration: BoxDecoration(
        color: roadToGoal >= 100 ? _green : _red,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          "$roadToGoal% of goal",
          style: TextStyle(color: Color(0xffffffff)),
        ),
      ),
    );
  }
}
