import 'package:counter/i18n/app_localization.dart';
import 'package:counter/widgets/common/ColoredTextField.dart';
import 'package:counter/widgets/common/expanded_widgets.dart';
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
    final locale = AppLocalization.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ExpandedLeft(child: TextLabel(locale.goal)),
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
