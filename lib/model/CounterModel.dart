import 'package:counter/model/ColorPalette.dart';
import 'package:flutter/cupertino.dart';

const _colId = "id";
const _colTitle = "title";
const _colValue = "value";
const _colGoal = "goal";
const _colUnit = "unit";
const _colColorIndex = "color_index";

class CounterItem {
  const CounterItem({
    this.id,
    @required this.title,
    @required this.value,
    @required this.goal,
    this.unit = "",
    this.colorIndex = ColorPalette.blue,
  });

  final int id;
  final String title;
  final int value;
  final int goal;
  final String unit;
  final int colorIndex;

  bool get isGoalReached => value >= goal;

  Map<String, dynamic> toMap() => <String, dynamic>{
        _colId: id,
        _colTitle: title,
        _colValue: value,
        _colGoal: goal,
        _colUnit: unit,
        _colColorIndex: colorIndex,
      };

  CounterItem.fromMap(Map<String, dynamic> map)
      : this(
          id: map[_colId],
          title: map[_colTitle],
          value: map[_colValue],
          goal: map[_colGoal],
          unit: map[_colUnit],
          colorIndex: map[_colColorIndex],
        );
}
