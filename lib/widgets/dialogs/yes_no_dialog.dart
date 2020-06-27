import 'package:flutter/material.dart';

Future<bool> yesNoDialog(
  BuildContext context, {
  @required String message,
  @required String yesText,
  @required String noText,
  @required Color color,
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
