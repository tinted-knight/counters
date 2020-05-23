import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

import 'input_dialog.dart';

showMissingDatePicker(
  BuildContext context,
  CounterItem counter,
  Function(CounterItem, String, DateTime) onDatePicked,
) async {
  final dateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1917),
    lastDate: DateTime(2042),
  );
  if (dateTime != null) {
    final value = await inputDialog(context, hint: "", counter: counter);
    if (value != null) {
      onDatePicked(counter, value, dateTime);
    }
  }
}
