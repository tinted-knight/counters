import 'package:counter/views/details/rows/DetailsTextField.dart';
import 'package:flutter/material.dart';

import '../TextLabel.dart';

class GoalRow extends StatelessWidget {
  const GoalRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ExpandedLeft(child: TextLabel("Goal")),
        ExpandedRight(child: DetailsTextField("4000")),
      ],
    );
  }
}
