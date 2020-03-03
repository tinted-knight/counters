import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
    this.buttonColor,
    this.onSave,
    this.onCancel,
    this.onStat,
  }) : super(key: key);

  final Function onSave;
  final Function onCancel;
  final Function onStat;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(buttonColor: buttonColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: FlatButton.icon(
              icon: Icon(Icons.chevron_left),
              label: Text("Cancel"),
              onPressed: onCancel,
//            color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: MaterialButton(
              child: Text("Stats"),
              onPressed: onStat,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
              child: RaisedButton(
                colorBrightness: Brightness.dark,
                child: Text("Save"),
                onPressed: onSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
