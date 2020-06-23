import 'package:counter/model/CounterModel.dart';
import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:flutter/material.dart';

import 'CounterIcon.dart';
import 'CounterTitle.dart';
import 'CounterValue.dart';

class CounterRow extends StatelessWidget {
  const CounterRow(
    this.item, {
    Key key,
  }) : super(key: key);

  final CounterItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: neuOuterDecoration,
      child: rowContent,
    );
  }

  Widget get rowContent => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CounterIcon(item.isGoalReached),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: CounterTitle(item.title),
            ),
          ),
          CounterValue(item),
        ],
      );
}
