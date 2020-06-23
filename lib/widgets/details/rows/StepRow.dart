import 'package:counter/i18n/app_localization.dart';
import 'package:counter/widgets/common/ColoredTextField.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';
import '../../common/expanded_widgets.dart';

class StepRow extends StatelessWidget {
  const StepRow({Key key, this.controller, this.hasError = false}) : super(key: key);

  final TextEditingController controller;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final lz = AppLocalization.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ExpandedLeft(child: TextLabel(lz.step)),
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
