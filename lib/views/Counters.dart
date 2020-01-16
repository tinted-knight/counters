import 'package:flutter/material.dart';

class CounterItem {
  const CounterItem(this.title, this.value, this.isGoalReached);

  final String title;
  final int value;
  final bool isGoalReached;
}

final kCounterTitleStyle = TextStyle().copyWith(
  fontSize: 18.0,
);

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
            Text(
              items[index].title,
              style: kCounterTitleStyle,
            ),
            Text(items[index].value.toString()),
          ],
        );
      },
    );
  }
}
