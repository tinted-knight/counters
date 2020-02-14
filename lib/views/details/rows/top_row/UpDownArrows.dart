import 'package:flutter/material.dart';

class UpDownArrows extends StatelessWidget {
  const UpDownArrows({
    this.upButtonTap,
    this.downButtonTap,
    Key key,
  }) : super(key: key);

  final Function upButtonTap;
  final Function downButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: CircleBorder(),
            splashColor: Colors.black.withOpacity(0.25),
            onTap: downButtonTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: CircleBorder(),
            splashColor: Colors.black.withOpacity(0.25),
            onTap: upButtonTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ),
      ],
    );
  }
}