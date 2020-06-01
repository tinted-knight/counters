import 'package:counter/i18n/app_localization.dart';
import 'package:flutter/material.dart';

class ChartBottomAppBar extends StatelessWidget {
  const ChartBottomAppBar({
    Key key,
    this.onBackPressed,
    this.onAddPressed,
    this.onClearPressed,
    this.onFilterPressed,
  }) : super(key: key);

  final Function onBackPressed;
  final Function onAddPressed;
  final Function onClearPressed;
  final Function onFilterPressed;

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
            icon: Icon(Icons.delete_sweep, semanticLabel: lz.clearHistory),
            tooltip: lz.clearHistory,
            onPressed: onClearPressed,
          ),
          IconButton(
            icon: Icon(Icons.filter_7, semanticLabel: lz.days7),
            tooltip: lz.days7,
            onPressed: onFilterPressed,
          ),
          IconButton(
            icon: Icon(Icons.add, semanticLabel: lz.addMissigValue),
            tooltip: lz.addMissigValue,
            onPressed: onAddPressed,
          ),
        ],
      ),
    );
  }
}
