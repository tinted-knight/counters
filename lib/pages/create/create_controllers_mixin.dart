import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

mixin CreateControllersMixin {
  final stepCtrl = TextEditingController();
  final goalCtrl = TextEditingController();
  final unitCtrl = TextEditingController();
  final titleCtrl = TextEditingController();

  int color = ColorPalette.green;

  void setColor(int newColor) {
    color = newColor;
  }

  CounterItem composeFromControllers() => CounterItem(
        title: titleCtrl.text,
        step: intValueOf(stepCtrl.text),
        goal: intValueOf(goalCtrl.text),
        unit: unitCtrl.text,
        colorIndex: color,
      );

  int intValueOf(String s) => int.tryParse(s) ?? -1;

  bool isValid(CounterItem item) => !item.hasInvalid;

  void disposeControllers() {
    stepCtrl.dispose();
    goalCtrl.dispose();
    unitCtrl.dispose();
    titleCtrl.dispose();
  }
}
