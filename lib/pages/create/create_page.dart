import 'package:counter/views/create/rows/PropertyRow.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  static const route = "/create";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create counter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: null,
          )
        ],
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return LayoutBuilder(
        builder: (ctx, viewport) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewport.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      PropertyRow.title("Title", null),
                      PropertyRow.step("Step", null),
                      PropertyRow.goal("Goal", null),
                      PropertyRow.unit("Unit", null),
                    ],
                  ),
                ),
              ),
            ));
  }
}
