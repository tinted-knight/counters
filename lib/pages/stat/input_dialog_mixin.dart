import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

import '../../model/ColorPalette.dart';

mixin InputDialogMixin {
  Future<String> inputDialog(BuildContext context, {String hint, CounterItem counter}) async {
    String newValue;
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(counter.title),
        content: TextField(
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Daily goal: ${counter.goal}",
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
            child: Text("Submit"),
            color: counter.colorValue,
            textColor: Color(0xffffffff),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
  }
}
