import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

mixin CreateControllersMixin {
  // todo debug to easy create a counter
  final stepCtrl = TextEditingController()..text = "42";
  final goalCtrl = TextEditingController()..text = "101";
  final unitCtrl = TextEditingController()..text = "timess";
  final titleCtrl = TextEditingController()..text = "Title1";

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

  int intValueOf(String s) {
    print('>validate: $s');
    return int.tryParse(s) ?? -1;
  }

  bool isValid(CounterItem item) => !item.hasInvalid;

  void disposeControllers() {
    stepCtrl.dispose();
    goalCtrl.dispose();
    unitCtrl.dispose();
    titleCtrl.dispose();
  }
}
