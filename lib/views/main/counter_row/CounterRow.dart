import 'package:counter/model/CounterModel.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CounterIcon(item.isGoalReached),
              CounterTitle(item.title),
              CounterValue(item),
            ],
          ),
        ],
      ),
    );
  }
}