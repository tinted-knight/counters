import 'package:flutter/material.dart';

import 'ColoredTextField.dart';
import 'TextLabel.dart';
import 'expanded_widgets.dart';

enum ValueType { str, int, color }

class PropertyRow extends StatelessWidget {
  const PropertyRow(
    this.label, {
    this.type,
    this.onlyDigits = false,
    this.hasError = false,
    this.textCapitalization = TextCapitalization.none,
    @required this.controller,
    this.autoFocus = false,
    Key key,
  }) : super(key: key);

  const PropertyRow.title({String label, TextEditingController controller})
      : this(
          label,
          type: ValueType.str,
          textCapitalization: TextCapitalization.words,
          controller: controller,
          autoFocus: true,
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

  const PropertyRow.unit({String label, TextEditingController controller})
      : this(
          label,
          type: ValueType.str,
          controller: controller,
        );

  final String label;
  final ValueType type;
  final bool onlyDigits;
  final TextCapitalization textCapitalization;
  final bool hasError;
  final TextEditingController controller;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ExpandedLeft(child: TextLabel(label, hasError: hasError)),
          ExpandedRight(
            child: ColoredTextField(
              controller: controller,
              onlyDigits: onlyDigits,
              textCapitalization: textCapitalization,
              autoFocus: autoFocus,
            ),
          ),
        ],
      ),
    );
  }
}
