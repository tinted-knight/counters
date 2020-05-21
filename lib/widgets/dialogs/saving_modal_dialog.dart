import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

void showSavingDialog(BuildContext context, {Color accent}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: accent ?? ThemeLight.button),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text("saving..."),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
