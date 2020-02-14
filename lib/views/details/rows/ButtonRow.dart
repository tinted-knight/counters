import 'package:flutter/material.dart';

enum ButtonType { stats, cancel, save }

typedef ButtonClick = Function(ButtonType);

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
    this.onClick,
  }) : super(key: key);

  final ButtonClick onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
          child: FlatButton.icon(
            icon: Icon(Icons.chevron_left),
            label: Text("Cancel"),
            onPressed: () => onClick(ButtonType.cancel),
//            color: Colors.black,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
          child: MaterialButton(
            child: Text("Stats"),
            onPressed: () => onClick(ButtonType.stats),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: RaisedButton(
              colorBrightness: Brightness.dark,
              child: Text("Save"),
              onPressed: () => onClick(ButtonType.save),
            ),
          ),
        ),
      ],
    );
  }
}
