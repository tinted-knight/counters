import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/material.dart';

mixin InputDialogMixin on StatelessWidget {
  Future<String> inputDialog(BuildContext context,
      {HistoryModel entry, CounterItem counter}) async {
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
            hintText: entry.valueString,
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
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
  }
}
