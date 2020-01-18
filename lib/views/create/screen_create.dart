import 'package:counter/views/create/rows/PropertyRow.dart';
import 'package:flutter/material.dart';

class ScreenCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Create counter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (ctx, viewport) => Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewport.maxHeight),
                child: IntrinsicHeight(
                  child: Column(children: <Widget>[
                    PropertyRow.title("Title"),
                    PropertyRow.step("Step"),
                    PropertyRow.goal("Goal"),
                    PropertyRow.unit("Unit"),
                    PropertyRow.color("Color"),
                  ],),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
