import 'package:counter/model/CounterModel.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

import 'CounterIcon.dart';
import 'CounterTitle.dart';
import 'CounterValue.dart';

const _kOffset = 3.0;
const _kBlur = 3.0;
const _kShadowLight = Color(0xAAFFFFFF);
const _kShadowDark = Color(0xAAD1CDC7);

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
      decoration: _neumorphicDecoration,
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

  // !galileo
  BoxDecoration get _neumorphicInnerDecoration => BoxDecoration(
        color: Colors.black.withOpacity(0.075),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(_kOffset, _kOffset),
            blurRadius: _kBlur,
            spreadRadius: -_kBlur,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );
}
