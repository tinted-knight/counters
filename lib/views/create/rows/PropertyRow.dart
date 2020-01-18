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
    Key key,
  }) : super(key: key);

  const PropertyRow.title(String label)
      : this(
          label,
          type: ValueType.str,
        );

  const PropertyRow.step(String label)
      : this(
          label,
          type: ValueType.int,
        );

  const PropertyRow.goal(String label)
      : this(
          label,
          type: ValueType.int,
        );

  const PropertyRow.unit(String label)
      : this(
          label,
          type: ValueType.str,
        );

  const PropertyRow.color(String label)
      : this(
          label,
          type: ValueType.color,
        );

  final String label;
  final ValueType type;

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
                ? ColoredTextField.forLight("4000")
                : ColoredTextField.justColor(ColorPalette.blue),
          ),
        ],
      ),
    );
  }
}
