import 'package:flutter/material.dart';

class CounterValue extends StatelessWidget {
  const CounterValue(
    this.value, {
    Key key,
  }) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Center(child: Text(value.toString(), style: kCounterValueStyle,)),
    );
  }
}

final kCounterValueStyle = TextStyle().copyWith(
  color: Colors.white,
);