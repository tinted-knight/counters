import 'package:charts_flutter/flutter.dart' as charts;
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart(
    this.values, {
    Key key,
    this.barColor = Colors.blue,
  }) : super(key: key);

  final List<HistoryModel> values;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    final series = [
      charts.Series<HistoryModel, String>(
        id: 'Stat',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(barColor),
        domainFn: (model, _) => model.dateForChart,
        measureFn: (model, _) => model.value,
        data: values,
      ),
    ];

    return charts.BarChart(
      series,
      // todo debug
      animate: false,
      domainAxis: charts.OrdinalAxisSpec(
        viewport: charts.OrdinalViewport(values[0].dateString, 7),
      ),
      behaviors: [
        charts.SlidingViewport(),
        charts.PanAndZoomBehavior(),
      ],
    );
  }
}