import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin ConfirmationDialogMixin {
  Future<bool> yesNoDialog(
    BuildContext context, {
    String message = "Do you want to save changes?",
    String yesText = "Yes",
    String noText = "No",
    Color color,
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(noText),
            textColor: color,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          RaisedButton(
            child: Text(yesText),
            color: color,
            textColor: Color(0xffffffff),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
