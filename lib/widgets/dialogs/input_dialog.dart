import 'package:counter/i18n/app_localization.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

Future<String> inputDialog(BuildContext context, {String hint, CounterItem counter}) async {
  String newValue;
  final locale = AppLocalization.of(context);

  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(counter.title),
      content: TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "${locale.dailyGoal}: ${counter.goal}",
          hintText: hint,
        ),
        onChanged: (value) {
          newValue = value;
        },
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        RaisedButton(
          child: Text(locale.submit),
          color: counter.colorValue,
          textColor: Color(0xffffffff),
          onPressed: () => Navigator.of(context).pop(newValue),
        ),
      ],
    ),
  );
}
