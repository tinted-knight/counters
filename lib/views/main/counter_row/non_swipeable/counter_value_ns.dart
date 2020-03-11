import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class CounterValueIncrement extends StatelessWidget {
  const CounterValueIncrement(this.item, {Key key, this.onTap}) : super(key: key);

  final CounterItem item;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _coloredValue(_valueNew()),
    );
  }

  Widget _coloredValue(Widget child) {
    return Container(
      alignment: Alignment.center,
      width: 80.0,
      decoration: BoxDecoration(
        color: ColorPalette.color(item.colorIndex),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: child,
    );
  }

  Widget _valueNew() => Padding(
        padding: const EdgeInsets.only(right: 4.0, left: 4.0),
        child: Text(
          "+ ${item.value.toString()}",
          style: kCounterValueStyle,
        ),
      );
}

// style
const kCounterValueStyle = TextStyle(
  color: Colors.white,
  fontFamily: "RobotoCondensed",
);
const kCounterUnitStyle = kCounterValueStyle;
