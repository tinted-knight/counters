import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:flutter/material.dart';

import 'rows/ButtonRow.dart';
import 'rows/StepRow.dart';
import 'rows/TopRow.dart';
import 'rows/UnitRow.dart';

class ScreenDetails extends StatelessWidget {
  const ScreenDetails(this.item, {Key key}) : super(key: key);

  final CounterItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: ColorPalette.bgColor(item.colorIndex),
      appBar: AppBar(
        backgroundColor: ColorPalette.bgColor(item.colorIndex),
        elevation: 0.0,
        title: Text(item.title),
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
            Hero(
              tag: item.title,
              child: Container(color: ColorPalette.bgColor(item.colorIndex)),
            ),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewport.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(child: TopRow(), height: 120.0),
                      SizedBox(height: 42.0),
                      StepRow(),
                      GoalRow(),
                      UnitRow(),
                      Expanded(child: ButtonRow()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
