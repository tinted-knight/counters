import 'package:flutter/material.dart';

import '../TextLabel.dart';
import 'DetailsTextField.dart';

class StepRow extends StatelessWidget {
  const StepRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ExpandedLeft(child: TextLabel("Increment step")),
        ExpandedRight(child: DetailsTextField("500")),
      ],
    );
  }
}
