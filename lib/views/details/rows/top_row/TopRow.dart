import 'package:counter/views/common/ColoredTextField.dart';
import 'package:counter/views/common/expanded_widgets.dart';
import 'package:flutter/material.dart';

import '../../../common/TextLabel.dart';
import '../up_down_row/UpDownArrows.dart';
import 'RoadToGoal.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
    this.value,
    this.goal,
    this.controller,
    this.upButtonTap,
    this.downButtonTap,
    this.resetButtonTap,
    this.hasError = false,
  }) : super(key: key);

  final int value;
  final int goal;
  final TextEditingController controller;
  final Function upButtonTap;
  final Function downButtonTap;
  final Function resetButtonTap;
  final bool hasError;

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
                  textColor: hasError ? Colors.red : null,
                ),
              ),
              UpDownArrows(
                upButtonTap: upButtonTap,
                downButtonTap: downButtonTap,
                resetButtonTap: resetButtonTap,
              ),
            ],
          ),
        ),
        Expanded(child: RoadToGoal(roadToGoal)),
      ],
    );
  }
}
