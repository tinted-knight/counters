import 'package:flutter/material.dart';

import 'ripple_circle_button.dart';

class UpDownArrows extends StatelessWidget {
  const UpDownArrows({
    this.upButtonTap,
    this.downButtonTap,
    this.resetButtonTap,
    Key key,
  }) : super(key: key);

  final Function upButtonTap;
  final Function downButtonTap;
  final Function resetButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RippleCircleButton(
          iconData: Icons.keyboard_arrow_down,
          onTap: downButtonTap,
        ),
        RippleCircleButton(
          iconData: Icons.keyboard_arrow_up,
          onTap: upButtonTap,
        ),
        RippleCircleButton(
          iconData: Icons.autorenew,
          onTap: resetButtonTap,
        ),
      ],
    );
  }
}
