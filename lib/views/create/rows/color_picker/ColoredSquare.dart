import 'package:counter/model/ColorPalette.dart';
import 'package:flutter/material.dart';

class ColoredSquare extends StatelessWidget {
  const ColoredSquare({
    Key key,
    @required this.color,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final int color;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Ink(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: ColorPalette.color(color),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
