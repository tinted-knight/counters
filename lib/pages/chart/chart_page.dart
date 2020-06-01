import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/i18n/app_localization.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:counter/views/stat/bar_chart.dart';
import 'package:counter/views/stat/chart_bottom_appBar.dart';
import 'package:counter/views/stat/stat_list_tile.dart';
import 'package:counter/widgets/debug_error_message.dart';
import 'package:counter/widgets/dialogs/input_dialog.dart';
import 'package:counter/widgets/dialogs/show_date_picker.dart';
import 'package:counter/widgets/dialogs/yes_no_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/HistoryModel.dart';
import 'chart_bloc.dart';
import 'chart_state.dart';

class ChartPage extends StatelessWidget {
  static const route = "/chart";

  @override
  Widget build(BuildContext context) {
    final lz = AppLocalization.of(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final ChartBloc chartBloc = BlocProvider.of<ChartBloc>(context);
    chartBloc.load(counter);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildTabBar(chart: lz.chart, list: lz.list),
        body: BlocStreamBuilder<ChartState>(
          bloc: chartBloc,
          oneShotListener: (state) async {
            if (state.hasCanceled) navBloc.pop();

            if (state.itemExists) {
              final confirmed = await yesNoDialog(
                context,
                color: counter.colorValue,
                message: lz.itemAlreadyExists,
                yesText: lz.yes,
                noText: lz.no,
              );
              if (confirmed) {
                chartBloc.updateValue(state.missingValue.item, state.missingValue.value);
              }
            }
          },
          builder: (context, state) {
            if (state.hasCanceled) return Container();

            if (state.isLoading || state.isUpdating) {
              return Center(child: CircularProgressIndicator(backgroundColor: counter.colorValue));
            }

            if (state.isEmpty) return EmptyChart();

            if (state.hasLoaded) return renderStateLoaded(state.stat, counter, chartBloc);

            return Center(child: YouShouldNotSeeThis());
          },
        ),
        bottomNavigationBar: ChartBottomAppBar(
          onBackPressed: chartBloc.backPressed,
          onAddPressed: () => showMissingDatePicker(context, counter, chartBloc.addMissingValue),
          onClearPressed: () async {
            await chartBloc.clearHistory(counter);
            countersBloc.reload();
          },
        ),
      ),
    );
  }

  PreferredSize buildTabBar({String chart, String list}) => PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(child: Container()),
                TabBar(
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(chart),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(list),
                    ),
                  ],
                  labelColor: Color(0xff212121),
                  indicator: neuInnerDecoration,
                ),
              ],
            ),
          ),
        ),
      );

  Widget renderStateLoaded(List<HistoryModel> values, CounterItem counter, ChartBloc chartBloc) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          children: [
            // !deprecated
//          BezierStatChart(
//            values: values,
//            lineColor: counter.colorValue,
//          ),
            BarChart(values, barColor: counter.colorValue),
            ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) => StatListTile(
                entry: values[index],
                counter: counter,
                onValueChanged: (value) => chartBloc.updateValue(values[index], value),
                onEditTap: (statEntry) => inputDialog(
                  context,
                  hint: statEntry.valueString,
                  counter: counter,
                ),
              ),
            ),
          ],
        ),
      );
}

class EmptyChart extends StatelessWidget {
  const EmptyChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lz = AppLocalization.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          lz.emptyChart,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
