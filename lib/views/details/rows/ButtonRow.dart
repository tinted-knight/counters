import 'package:flutter/material.dart';

enum ButtonType { delete, cancel, save }

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
          child: MaterialButton(
            child: Text("Delete", style: TextStyle(color: Color(0xffff0000))),
            onPressed: () {},
            color: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
          child: MaterialButton(
            child: Row(children: <Widget>[
              Icon(Icons.chevron_left, color: Colors.white),
              Text("Cancel", style: TextStyle(color: Colors.white))
            ],),
            onPressed: () {},
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: MaterialButton(
              child: Text("Save"),
              onPressed: () => onClick(ButtonType.save),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
