import 'package:counter/i18n/app_localization.dart';
import 'package:counter/widgets/common/ColoredTextField.dart';
import 'package:counter/widgets/common/expanded_widgets.dart';
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
    final lz = AppLocalization.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ExpandedLeft(child: TextLabel(lz.unit)),
        ExpandedRight(
          child: ColoredTextField(controller: controller),
        ),
      ],
    );
  }
}
