import 'package:counter/i18n/app_localization.dart';
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
    final lz = AppLocalization.of(context);

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
            icon: Icon(Icons.add, semanticLabel: lz.addMissigValue),
            tooltip: lz.addMissigValue,
            onPressed: onAddPressed,
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep, semanticLabel: lz.clearHistory),
            tooltip: lz.clearHistory,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
