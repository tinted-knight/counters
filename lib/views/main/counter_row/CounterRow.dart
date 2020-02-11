import 'package:counter/model/CounterModel.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

import 'CounterIcon.dart';
import 'CounterTitle.dart';
import 'CounterValue.dart';

const _kOffset = 6.0;
const _kBlur = 6.0;
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
    return _new;
  }

  Widget get _new => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: ThemeLight.scaffoldBgColor,
          boxShadow: [
            // kind of neomorphism
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
        ),
        child: _newRow,
      );

  Widget get _old => Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: _row,
      );

  Widget get _row => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CounterIcon(item.isGoalReached),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: CounterTitle(item.title),
            ),
          ),
          CounterValue(item),
        ],
      );

  Widget get _newRow => Row(
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
}
