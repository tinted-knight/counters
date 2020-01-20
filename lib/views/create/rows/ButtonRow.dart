import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key, this.onCreate, this.onCancel,
  }) : super(key: key);

  final Function onCreate;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
          child: MaterialButton(
            child: Row(children: <Widget>[
              Icon(Icons.chevron_left),
              Text("Cancel")
            ],),
            onPressed: onCancel,
            color: Colors.black,
            colorBrightness: Brightness.dark,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: RaisedButton(
              child: Text("Create"),
              colorBrightness: Brightness.dark,
              onPressed: onCreate,
            ),
          ),
        ),
      ],
    );
  }
}