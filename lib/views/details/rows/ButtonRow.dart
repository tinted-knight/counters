import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
    this.buttonColor,
    this.onSave,
    this.onCancel,
    this.onStat,
    this.isSaving,
  }) : super(key: key);

  final Function onSave;
  final Function onCancel;
  final Function onStat;
  final bool isSaving;
  final Color buttonColor;

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
            label: Text("Back"),
            onPressed: onCancel,
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
            child: isSaving ? savingButton(context) : saveButton(),
          ),
        ),
      ],
    );
  }

  Widget saveButton() => RaisedButton(
        colorBrightness: Brightness.dark,
        color: buttonColor,
        child: Text("Save"),
        onPressed: onSave,
      );

  Widget savingButton(BuildContext context) => RaisedButton(
        onPressed: onSave,
        colorBrightness: Brightness.dark,
        color: buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                width: 20.0,
                height: 20.0,
                padding: EdgeInsets.all(2.0),
                margin: EdgeInsets.only(right: 8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            Text("Saving"),
          ],
        ),
      );
}
