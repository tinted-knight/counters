import 'package:counter/model/ColorPalette.dart';
import 'package:counter/views/common/ColoredTextField.dart';
import 'package:counter/views/common/ColoredTextLabel.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';
import '../../common/DetailsTextField.dart';

enum ValueType { str, int, color }

class PropertyRow extends StatelessWidget {
  const PropertyRow(
    this.label, {
    this.type,
    this.onlyDigits = false,
    @required this.controller,
    Key key,
  }) : super(key: key);

  const PropertyRow.title(String label, TextEditingController controller)
      : this(
          label,
          type: ValueType.str,
          controller: controller,
        );

  const PropertyRow.step(String label, TextEditingController controller)
      : this(
          label,
          type: ValueType.int,
          controller: controller,
          onlyDigits: true,
        );

  const PropertyRow.goal(String label, TextEditingController controller)
      : this(
          label,
          type: ValueType.int,
          controller: controller,
          onlyDigits: true,
        );

  const PropertyRow.unit(String label, TextEditingController controller)
      : this(
          label,
          type: ValueType.str,
          controller: controller,
        );

  const PropertyRow.color(String label)
      : this(
          label,
          type: ValueType.color,
          controller: null,
        );

  final String label;
  final ValueType type;
  final bool onlyDigits;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ExpandedLeft(child: ColoredTextLabel.forLight(label)),
          ExpandedRight(
            child: type != ValueType.color
                ? ColoredTextField.forLight(
                    controller: controller,
                    onlyDigits: onlyDigits,
                  )
                : ColoredTextField.justColor(ColorPalette.blue),
          ),
        ],
      ),
    );
  }
}
