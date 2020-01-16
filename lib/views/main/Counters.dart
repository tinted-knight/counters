import 'package:flutter/material.dart';

import 'CounterTitle.dart';
import 'CounterValue.dart';

class CounterItem {
  const CounterItem(this.title, this.value, this.isGoalReached);

  final String title;
  final int value;
  final bool isGoalReached;
}

class Counters extends StatelessWidget {
  const Counters({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<CounterItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CounterIcon(),
            CounterTitle(items[index].title),
            CounterValue(items[index].value),
          ],
        );
      },
    );
  }
}

class CounterIcon extends StatelessWidget {
  const CounterIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.check);
  }
}
