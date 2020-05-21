import 'package:bezier_chart/bezier_chart.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/material.dart';

class BezierStatChart extends StatelessWidget {
  const BezierStatChart({
    Key key,
    @required this.values,
    this.lineColor = Colors.blue,
    this.accentColor = Colors.amber,
  }) : super(key: key);

  final List<HistoryModel> values;
  final Color lineColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 0.0,
      child: BezierChart(
        fromDate: DateTime.fromMillisecondsSinceEpoch(values.last.date),
        toDate: DateTime.now(),
        bezierChartScale: BezierChartScale.WEEKLY,
        selectedDate: DateTime.now(),
        series: [
          BezierLine(
            lineColor: lineColor,
            label: "Stat",
            dataPointFillColor: accentColor,
            dataPointStrokeColor: lineColor,
            onMissingValue: (dayTime) {
              return 0;
            },
            data: values
                .map(
                  (e) => DataPoint(
                      value: e.value.toDouble(),
                      xAxis: DateTime.fromMillisecondsSinceEpoch(e.date)),
                )
                .toList(),
          )
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
//          verticalIndicatorColor: Colors.red,
          showVerticalIndicator: true,
          xAxisTextStyle: TextStyle(
            fontFamily: "RobotoCondensed",
            fontSize: 12.0,
            color: Color(0xff313131),
          ),
          verticalIndicatorFixedPosition: false,
          footerHeight: 30.0,
        ),
      ),
    );
  }
}
