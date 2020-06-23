import 'package:flutter/material.dart';

import 'icon_button_indicator.dart';

class DeleteActionButton extends IconButtonIndicator {
  DeleteActionButton({bool inAction, Function onPressed, String semanticLabel})
      : super(
          inAction: inAction,
          onPressed: onPressed,
          label: semanticLabel,
        );

  @override
  IconData get iconData => Icons.delete;
}

class SaveActionButton extends IconButtonIndicator {
  SaveActionButton({bool inAction, Function onPressed, String semanticLabel})
      : super(
          inAction: inAction,
          onPressed: onPressed,
          label: semanticLabel,
        );

  @override
  IconData get iconData => Icons.save;
}

class ColorActionButton extends IconButtonIndicator {
  ColorActionButton({bool inAction, Function onPressed, Color color, String semanticLabel})
      : super(
          inAction: inAction,
          onPressed: onPressed,
          color: color,
          label: semanticLabel,
        );

  @override
  IconData get iconData => Icons.color_lens;
}
