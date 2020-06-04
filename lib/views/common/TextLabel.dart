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
      decoration: !hasError ? neuOuterDecoration : neuOuterDecorationError,
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        textAlign: centered ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
