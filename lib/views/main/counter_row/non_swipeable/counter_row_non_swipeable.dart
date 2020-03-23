import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/main/counter_row/non_swipeable/counter_value_ns.dart';
import 'package:flutter/material.dart';

import '../CounterIcon.dart';
import '../CounterTitle.dart';

const _kOffset = 3.0;
const _kBlur = 3.0;
const _kShadowLight = Color(0xAAFFFFFF);
const _kShadowDark = Color(0xAAD1CDC7);

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
        decoration: _neumorphicDecoration,
        child: rowContent,
      ),
    );
  }

  Widget get rowContent => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: onDecrement,
            color: ColorPalette.color(item.colorIndex),
            tooltip: "Step down",
            icon: Icon(Icons.remove_circle),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: CounterTitle(item.title),
            ),
          ),
          CounterIcon(item.isGoalReached),
          CounterValueIncrement(item, onTap: onIncrement),
        ],
      );

  BoxDecoration get _neumorphicDecoration => BoxDecoration(
        color: ThemeLight.scaffoldBgColor,
        boxShadow: [
          // kind of neumorphism
          // top shadow - light
          BoxShadow(
            color: _kShadowLight,
            offset: Offset(-_kOffset, -_kOffset),
            blurRadius: _kBlur,
          ),
          // botttom shadow - dark
          BoxShadow(
            color: _kShadowDark,
            offset: Offset(_kOffset, _kOffset),
            blurRadius: _kBlur,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );
}