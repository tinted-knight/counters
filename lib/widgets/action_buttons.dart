import 'package:flutter/material.dart';

import 'icon_button_indicator.dart';

class DeleteActionButton extends IconButtonIndicator {
  DeleteActionButton({bool inAction, Function onPressed})
      : super(
          inAction: inAction,
          onPressed: onPressed,
        );

  @override
  IconData get iconData => Icons.delete;

  @override
  String get label => "Delete";
}

class SaveActionButton extends IconButtonIndicator {
  SaveActionButton({bool inAction, Function onPressed})
      : super(
          inAction: inAction,
          onPressed: onPressed,
        );

//  @override
//  Color get color => Colors.white;

  @override
  IconData get iconData => Icons.save;

  @override
  String get label => "Delete";
}

class ColorActionButton extends IconButtonIndicator {
  ColorActionButton({bool inAction, Function onPressed, Color color})
      : super(
          inAction: inAction,
          onPressed: onPressed,
          color: color,
        );

  @override
  IconData get iconData => Icons.color_lens;

  @override
  String get label => "Pick color";
}
