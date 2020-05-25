import 'package:counter/i18n/app_localization.dart';
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
    final lz = AppLocalization.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RippleCircleButton(
          iconData: Icons.keyboard_arrow_down,
          onTap: downButtonTap,
          semanticLabel: lz.up,
        ),
        RippleCircleButton(
          iconData: Icons.keyboard_arrow_up,
          onTap: upButtonTap,
          semanticLabel: lz.down,
        ),
        RippleCircleButton(
          iconData: Icons.autorenew,
          onTap: resetButtonTap,
          semanticLabel: lz.reset,
        ),
      ],
    );
  }
}
