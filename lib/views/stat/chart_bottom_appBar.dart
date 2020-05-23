import 'package:flutter/material.dart';

class ChartBottomAppBar extends StatelessWidget {
  const ChartBottomAppBar({
    Key key,
    this.onBackPressed,
    this.onAddPressed,
  }) : super(key: key);

  final Function onBackPressed;
  final Function onAddPressed;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onBackPressed,
          ),
          Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add missing value",
            onPressed: onAddPressed,
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep),
            tooltip: "Clear history",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}