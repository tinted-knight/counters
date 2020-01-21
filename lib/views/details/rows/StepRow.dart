import 'package:counter/views/common/ColoredTextField.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';
import '../../common/DetailsTextField.dart';

class StepRow extends StatelessWidget {
  const StepRow({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ExpandedLeft(child: TextLabel("Increment step")),
        ExpandedRight(
            child: ColoredTextField(
          controller: controller,
          onlyDigits: true,
        )),
      ],
    );
  }
}
