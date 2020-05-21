import 'package:counter/model/ColorPalette.dart';
import 'package:flutter/material.dart';

import 'ColoredSquare.dart';

typedef ColorPicked = Function(int color);

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    Key key,
    @required this.onColorPicked,
    @required this.selected,
  }) : super(key: key);

  final ColorPicked onColorPicked;
  final int selected;

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selected;

  final colors = ColorPalette.intPallete;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0, left: 8.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: colors
            .map((color) => ColoredSquare(
                  color: color,
                  isSelected: selected == color,
                  onTap: () {
                    setState(() => selected = color);
                    widget.onColorPicked(selected);
                  },
                ))
            .toList(),
      ),
    );
  }
}
