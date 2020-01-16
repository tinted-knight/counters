import 'package:flutter/material.dart';

class DetailsTextField extends StatelessWidget {
  const DetailsTextField(
    this.title, {
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: title);
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[500],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
        ),
      ),
    );
  }
}

class ExpandedRight extends StatelessWidget {
  const ExpandedRight({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 4.0, 16.0, 4.0),
        child: child,
      ),
    );
  }
}
