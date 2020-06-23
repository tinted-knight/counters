import 'package:counter/theme/light_theme.dart';
import 'package:flutter/material.dart';

class IconButtonIndicator extends StatelessWidget {
  const IconButtonIndicator({
    Key key,
    this.inAction = false,
    this.onPressed,
    this.color = ThemeLight.iconPrimary,
    this.label = "Error"
  }) : super(key: key);

  final bool inAction;
  final Function onPressed;

  final Color color;
  final IconData iconData = Icons.error;
  final String label;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: label,
      icon: inAction
          ? Container(
              width: 24.0,
              height: 24.0,
              padding: EdgeInsets.all(4.0),
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: color),
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            )
          : Icon(iconData, semanticLabel: label, color: color),
      onPressed: onPressed ?? () {},
    );
  }
}
