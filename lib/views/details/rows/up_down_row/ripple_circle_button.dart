import 'package:flutter/material.dart';

class RippleCircleButton extends StatelessWidget {
  const RippleCircleButton({
    Key key,
    this.onTap,
    this.iconData,
    this.semanticLabel,
  }) : super(key: key);

  final Function onTap;
  final IconData iconData;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: CircleBorder(),
        splashColor: Colors.black.withOpacity(0.25),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(iconData, semanticLabel: semanticLabel),
        ),
      ),
    );
  }
}
