import 'package:counter/views/common/ColoredTextField.dart';
import 'package:counter/views/common/DetailsTextField.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';

class GoalRow extends StatelessWidget {
  const GoalRow({
    Key key,
    this.controller,
    this.hasError = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ExpandedLeft(child: TextLabel("Goal")),
        ExpandedRight(
          child: ColoredTextField(
            controller: controller,
            onlyDigits: true,
            textColor: hasError ? Colors.red : null,
          ),
        ),
      ],
    );
  }
}
