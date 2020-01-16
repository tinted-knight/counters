import 'package:counter/views/details/rows/DetailsTextField.dart';
import 'package:flutter/material.dart';

import '../TextLabel.dart';

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
