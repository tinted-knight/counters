import 'package:counter/i18n/app_localization.dart';
import 'package:counter/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ChartBottomAppBar extends StatelessWidget {
  const ChartBottomAppBar({
    Key key,
    this.onBackPressed,
    this.onAddPressed,
    this.onClearPressed,
    this.onFilterPressed,
    this.onCalendarPressed,
//    this.onMissingPressed
  }) : super(key: key);

  final Function onBackPressed;
  final Function onAddPressed;
  final Function onClearPressed;
  final Function onFilterPressed;
  final Function onCalendarPressed;
//  final Function onMissingPressed;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalization.of(context);

    return BottomAppBar(
      elevation: 0.0,
      color: ThemeLight.scaffoldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onBackPressed,
          ),
          Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(Icons.delete_sweep, semanticLabel: locale.clearHistory),
            tooltip: locale.clearHistory,
            onPressed: onClearPressed,
          ),
          IconButton(
            icon: Icon(Icons.filter_7, semanticLabel: locale.days7),
            tooltip: locale.days7,
            onPressed: onFilterPressed,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, semanticLabel: locale.chooseDate),
            tooltip: locale.chooseDate,
            onPressed: onCalendarPressed,
          ),
//          IconButton(
//            icon: Icon(Icons.playlist_add, semanticLabel: lz.fillAllMissing),
//            tooltip: lz.fillAllMissing,
//            onPressed: onMissingPressed,
//          ),
          IconButton(
            icon: Icon(Icons.add, semanticLabel: locale.addMissigValue),
            tooltip: locale.addMissigValue,
            onPressed: onAddPressed,
          ),
        ],
      ),
    );
  }
}
