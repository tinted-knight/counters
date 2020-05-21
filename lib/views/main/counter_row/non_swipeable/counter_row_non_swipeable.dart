import 'package:counter/model/CounterModel.dart';
import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:counter/views/main/counter_row/non_swipeable/counter_value_ns.dart';
import 'package:flutter/material.dart';

import '../CounterIcon.dart';
import '../CounterTitle.dart';

class CounterRowNonSwipeable extends StatelessWidget {
  const CounterRowNonSwipeable(
    this.item, {
    Key key,
    this.onTap,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  final CounterItem item;
  final Function onTap;
  final Function onIncrement;
  final Function onDecrement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: neuOuterDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 32.0, right: 16.0),
                child: CounterTitle(item.title),
              ),
            ),
            CounterIcon(item.isGoalReached),
            CounterValueIncrement(item, onTap: onIncrement),
          ],
        ),
      ),
    );
  }
}
