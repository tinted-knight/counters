import 'package:flutter/material.dart';

import '../../common/TextLabel.dart';
import '../../common/DetailsTextField.dart';

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
