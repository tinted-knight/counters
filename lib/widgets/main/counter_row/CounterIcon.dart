import 'package:flutter/material.dart';

class CounterIcon extends StatelessWidget {
  const CounterIcon(
    this.isVisible, {
    Key key,
  }) : super(key: key);

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _kIconPadding,
      child: isVisible
          ? Icon(Icons.check, size: _kIconSize)
          : SizedBox(width: _kIconSize, height: _kIconSize),
    );
  }
}

// style
const _kIconSize = 24.0;
const _kIconPadding = EdgeInsets.all(8.0);
