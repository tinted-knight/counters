import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

import '../../bloc/helper_functions.dart';

mixin DetailsControllersMixin {
  final valueCtrl = TextEditingController();
  final stepCtrl = TextEditingController();
  final goalCtrl = TextEditingController();
  final unitCtrl = TextEditingController();
  final titleCtrl = TextEditingController();

  void populateControllers(CounterItem counter) {
    valueCtrl.text = counter.value.toString();
    stepCtrl.text = counter.step.toString();
    goalCtrl.text = counter.goal.toString();
    unitCtrl.text = counter.unit;
    titleCtrl.text = counter.title;
  }

  CounterItem fillFromControllers(CounterItem item) => item.copyWith(
        title: titleCtrl.text,
        goal: intValueOf(goalCtrl.text),
        value: intValueOf(valueCtrl.text),
        step: intValueOf(stepCtrl.text),
        unit: unitCtrl.text,
      );

  bool isValid(CounterItem item) {
    if (item.hasInvalid) {
//      if (item.value < 0) valueCtrl.text += " : e";
//      if (item.step < 0) stepCtrl.text += " : e";
//      if (item.goal < 0) goalCtrl.text += " : e";
      return false;
    }
    return true;
  }

  int intValueOf(String s) => int.tryParse(s) ?? -1;

  void disposeControllers() {
    valueCtrl.dispose();
    stepCtrl.dispose();
    goalCtrl.dispose();
    unitCtrl.dispose();
    titleCtrl.dispose();
  }
}
