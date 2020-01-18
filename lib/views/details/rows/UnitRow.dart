import 'package:counter/views/common/DetailsTextField.dart';
import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';

class UnitRow extends StatelessWidget {
  const UnitRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ExpandedLeft(child: TextLabel("Unit")),
        ExpandedRight(child: DetailsTextField("ME")),
      ],
    );
  }
}
