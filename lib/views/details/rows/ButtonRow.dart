import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            MaterialButton(
              child: Text("Cancel"),
              onPressed: () {},
              color: Colors.black,
            ),
            MaterialButton(
              child: Text("Save"),
              onPressed: () {},
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
