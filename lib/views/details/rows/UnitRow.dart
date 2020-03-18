import 'package:counter/views/common/ColoredTextField.dart';
import 'package:counter/views/common/ExpandedRight.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';

class UnitRow extends StatelessWidget {
  const UnitRow({
    Key key,
    this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ExpandedLeft(child: TextLabel("Unit")),
        ExpandedRight(
          child: ColoredTextField(controller: controller),
        ),
      ],
    );
  }
}
