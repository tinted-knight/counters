import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
    this.onCreate,
    this.onCancel,
  }) : super(key: key);

  final Function onCreate;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _btnCancel(),
        Expanded(child: _btnSave()),
      ],
    );
  }

  Widget _btnCancel() => Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Icon(Icons.chevron_left),
              Text("Cancel"),
            ],
          ),
          onPressed: onCancel,
          colorBrightness: Brightness.light,
        ),
      );

  Widget _btnSave() => Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: RaisedButton(
          child: Text("Create"),
          colorBrightness: Brightness.dark,
          onPressed: onCreate,
        ),
      );
}
