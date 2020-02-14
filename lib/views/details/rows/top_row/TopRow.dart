import 'package:counter/views/common/ColoredTextField.dart';
import 'package:flutter/material.dart';

import '../../../common/TextLabel.dart';
import 'RoadToGoal.dart';
import 'UpDownArrows.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
    this.value,
    this.goal,
    this.controller,
    this.upButtonTap,
    this.downButtonTap,
  }) : super(key: key);

  final int value;
  final int goal;
  final TextEditingController controller;
  final Function upButtonTap;
  final Function downButtonTap;

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
              ExpandedLeft(child: TextLabel("Today", centered: true)),
              ExpandedLeft(
                  child: ColoredTextField(
                controller: controller,
                onlyDigits: true,
              )),
              UpDownArrows(upButtonTap: upButtonTap, downButtonTap: downButtonTap),
            ],
          ),
        ),
        Expanded(child: RoadToGoal(roadToGoal)),
      ],
    );
  }
}
