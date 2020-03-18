import 'package:counter/views/common/ColoredTextField.dart';
import 'package:flutter/material.dart';

import '../../views/common/DetailsTextField.dart';
import '../../views/common/TextLabel.dart';

enum ValueType { str, int, color }

class PropertyRow extends StatelessWidget {
  const PropertyRow(
    this.label, {
    this.type,
    this.onlyDigits = false,
    this.hasError = false,
    @required this.controller,
    Key key,
  }) : super(key: key);

  const PropertyRow.title({String label, TextEditingController controller})
      : this(
          label,
          type: ValueType.str,
          controller: controller,
        );

  const PropertyRow.step({String label, TextEditingController controller, bool hasError})
      : this(
          label,
          type: ValueType.int,
          controller: controller,
          onlyDigits: true,
          hasError: hasError,
        );

  const PropertyRow.goal({String label, TextEditingController controller, bool hasError})
      : this(
          label,
          type: ValueType.int,
          controller: controller,
          onlyDigits: true,
          hasError: hasError,
        );

  const PropertyRow.unit(String label, TextEditingController controller)
      : this(
          label,
          type: ValueType.str,
          controller: controller,
        );

  final String label;
  final ValueType type;
  final bool onlyDigits;
  final bool hasError;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ExpandedLeft(child: TextLabel(label)),
          ExpandedRight(
            child: ColoredTextField.forLight(
              controller: controller,
              onlyDigits: onlyDigits,
              textColor: hasError ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }
}
