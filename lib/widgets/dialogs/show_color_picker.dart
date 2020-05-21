import 'package:counter/widgets/color_picker/ColorPicker.dart';
import 'package:flutter/material.dart';

void showColorPicker(BuildContext context, {int currentColorIndex, Function(int) onColorPicked}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      child: ColorPicker(
        selected: currentColorIndex,
        onColorPicked: (newColor) {
          onColorPicked(newColor);
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}