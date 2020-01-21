import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class CounterValue extends StatelessWidget {
  const CounterValue(
    this.item, {
    Key key,
  }) : super(key: key);

  final CounterItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: item.id,
          child: Container(
            alignment: Alignment.center,
            width: 80.0,
            decoration: BoxDecoration(
              color: ColorPalette.color(item.colorIndex),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 80.0,
          decoration: BoxDecoration(
            color: ColorPalette.color(item.colorIndex),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          child: Text(
            "${item.value.toString()} ${item.unit}",
            style: kCounterValueStyle,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}

// style
final kCounterValueStyle = TextStyle().copyWith(
  color: Colors.white,
);
