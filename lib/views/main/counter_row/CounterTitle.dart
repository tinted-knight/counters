import 'package:flutter/material.dart';

class CounterTitle extends StatelessWidget {
  const CounterTitle(
    this.title, {
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: _kCounterTitleStyle,
      ),
    );
  }
}

final _kCounterTitleStyle = TextStyle().copyWith(
  fontSize: 18.0,
);
