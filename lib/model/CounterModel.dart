import 'package:counter/model/ColorPalette.dart';
import 'package:flutter/cupertino.dart';

const _colId = "id";
const _colTitle = "title";
const _colValue = "value";
const _colGoal = "goal";
const _colStep = "step";
const _colUnit = "unit";
const _colColorIndex = "color_index";

class CounterItem {
  const CounterItem({
    this.id,
    @required this.title,
    this.value = 0,
    @required this.step,
    @required this.goal,
    this.unit = "",
    this.colorIndex = ColorPalette.blue,
  });

  final int id;
  final String title;
  final int value;
  final int goal;
  final int step;
  final String unit;
  final int colorIndex;

  bool get isGoalReached => value >= goal;

  Map<String, dynamic> toMap() => <String, dynamic>{
        _colId: id,
        _colTitle: title,
        _colValue: value,
        _colGoal: goal,
        _colStep: step,
        _colUnit: unit,
        _colColorIndex: colorIndex,
      };

  CounterItem.fromMap(Map<String, dynamic> map)
      : this(
          id: map[_colId],
          title: map[_colTitle],
          value: map[_colValue],
          goal: map[_colGoal],
          step: map[_colStep],
          unit: map[_colUnit],
          colorIndex: map[_colColorIndex],
        );
}

extension ColorValue on CounterItem {
  Color get colorValue => ColorPalette.color(colorIndex);
}

extension CopyWith on CounterItem {
  CounterItem copyWith({
    int id,
    String title,
    int goal,
    int value,
    int step,
    String unit,
    int colorIndex,
  }) {
    return CounterItem(
      id: id ?? this.id,
      title: title ?? this.title,
      goal: goal ?? this.goal,
      value: value ?? this.value,
      step: step ?? this.step,
      unit: unit ?? this.unit,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  CounterItem stepUp() {
    print("stepUp: ${this.value} + ${this.step}");
    return this.copyWith(value: this.value + this.step);
  }

  CounterItem stepDown() {
    final newValue = this.value - this.step;
    print("stepDown: $newValue = ${this.value} - ${this.step}");
    if (newValue >= 0) return this.copyWith(value: newValue);
    return null;
  }

  CounterItem get flush => this.copyWith(value: 0);

  bool equalTo(CounterItem item) {
    if (this == item) return true;

//    if (title != item.title) {
//      print('equalTo: false, title');
//      return false;
//    }
//    if (value != item.value) {
//      print('equalTo: false, value');
//      return false;
//    }
//    if (step != item.step) {
//      print('equalTo: false, step');
//      return false;
//    }
//    if (goal != item.goal) {
//      print('equalTo: false, goal');
//      return false;
//    }
//    if (unit != item.unit) {
//      print('equalTo: false, unit');
//      return false;
//    }

    if (title != item.title ||
        value != item.value ||
        step != item.step ||
        goal != item.goal ||
        unit != item.unit) {
      return false;
    }

    return true;
  }
}

extension Validation on CounterItem {
  bool get hasInvalid => value < 0 || goal < 0 || step < 0;

  bool get hasStepError => step <= 0;

  bool get hasValueError => value < 0;

  bool get hasGoalError => goal < 0;
}
