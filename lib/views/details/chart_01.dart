import 'dart:math';

import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _barCount = 6;

class Chart01 extends StatelessWidget {
  const Chart01({
    Key key,
    this.counter,
    this.stat,
  }) : super(key: key);

  final CounterItem counter;
  final List<HistoryModel> stat;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(top: 64.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: counter.goal.toDouble(),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(
                  color: Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                margin: 20,
                getTitles: titleFor,
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(show: false),
            barGroups: barGroups(),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> barGroups() {
    final values = List<BarChartGroupData>();
    for (int i = 0; i <= _barCount; i++) {
      values.add(groupDataFor(i));
    }
    return values;
  }

  BarChartGroupData groupDataFor(int value) => BarChartGroupData(
        x: value,
        barRods: [
          BarChartRodData(
            y: min(stat[_barCount - value].value.toDouble(), counter.goal.toDouble()),
            color: ColorPalette.color(counter.colorIndex),
          )
        ],
        showingTooltipIndicators: [stat[_barCount - value].isZero],
      );

  String titleFor(double value) {
    final date = DateTime.fromMillisecondsSinceEpoch(stat[_barCount - value.toInt()].date);
    return DateFormat.MMMd().format(date);
  }
}

extension Double on HistoryModel {
  int get isZero => value == 0 ? 1 : 0;
}
