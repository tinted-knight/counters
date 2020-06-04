import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  const TextLabel(
    this.title, {
    Key key,
    this.centered = false,
    this.hasError = false,
  }) : super(key: key);

  final String title;
  final bool centered;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: !hasError
          ? neuOuterDecoration
          : neuOuterDecoration.copyWith(
              boxShadow: [
                // kind of neumorphism
                // top shadow - light
                BoxShadow(
                  color: _shadowLight,
                  offset: Offset(-_offset, -_offset),
                  blurRadius: _blur,
                ),
                // botttom shadow - dark
                BoxShadow(
                  color: _shadowDark,
                  offset: Offset(_offset, _offset),
                  blurRadius: _blur,
                ),
              ],
            ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        textAlign: centered ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}

const _offset = 1.0;
const _blur = 1.5;
const _shadowLight = Color(0xffffCDC7);
const _shadowDark = Color(0xffff0000);
