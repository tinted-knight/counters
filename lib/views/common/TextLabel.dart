import 'package:flutter/material.dart';

const _kTextLabelBg = Color(0xff212121);

class TextLabel extends StatelessWidget {
  const TextLabel(this.title, {Key key, this.centered = false}) : super(key: key);

  final String title;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kTextLabelBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        textAlign: centered ? TextAlign.center : TextAlign.start,
        style: TextStyle().copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class ExpandedLeft extends StatelessWidget {
  const ExpandedLeft({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
        child: child,
      ),
    );
  }
}
