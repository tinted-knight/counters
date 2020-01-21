import 'package:counter/views/common/ColoredTextField.dart';
import 'package:counter/views/common/DetailsTextField.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
    this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
            child: TextLabel("100% of goal"),
          ),
        ),
      ],
    );
  }
}
