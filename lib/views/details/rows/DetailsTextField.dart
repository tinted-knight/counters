import 'package:flutter/material.dart';

// styles
final _textFieldStyle = TextStyle(
  color: Color(0xff000000),
);
final _textFieldDecoration = BoxDecoration(
  color: Color(0xffffffff),
  borderRadius: BorderRadius.circular(8.0),
);
//

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
      decoration: _textFieldDecoration,
      child: TextField(
        controller: controller,
        style: _textFieldStyle,
        textAlign: TextAlign.center,
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
