import 'package:flutter/material.dart';

void showTextSnack(BuildContext context, {String msg}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(msg),
        ],
      ),
    ),
  );
}
