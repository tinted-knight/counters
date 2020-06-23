import 'package:flutter/material.dart';

class ExpandedRight extends StatelessWidget {
  const ExpandedRight({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 4.0, 16.0, 4.0),
        child: child,
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