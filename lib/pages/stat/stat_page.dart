import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/i18n/app_localization.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/stat/stat_bloc.dart';
import 'package:counter/pages/stat/stat_state.dart';
import 'package:counter/theme/neumorphicDecoration.dart';
import 'package:counter/views/stat/bar_chart.dart';
import 'package:counter/views/stat/chart_bottom_appBar.dart';
import 'package:counter/views/stat/stat_list_tile.dart';
import 'package:counter/widgets/dialogs/input_dialog.dart';
import 'package:counter/widgets/dialogs/show_date_picker.dart';
import 'package:counter/widgets/dialogs/yes_no_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/HistoryModel.dart';

class StatPage extends StatelessWidget {
  static const route = "/stat";

  @override
  Widget build(BuildContext context) {
    final lz = AppLocalization.of(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);
    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final StatBloc statBloc = BlocProvider.of<StatBloc>(context);
    statBloc.load(counter);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildTabBar(chart: lz.chart, list: lz.list),
        body: BlocStreamBuilder<StatState>(
          bloc: statBloc,
          oneShotListener: (state) async {
            if (state.hasCanceled) navBloc.pop();

            if (state.itemExists) {
              final confirmed = await yesNoDialog(
                context,
                color: counter.colorValue,
                message: lz.itemAlreadyExists,
              );
              if (confirmed) {
                statBloc.updateValue(state.missingValue.item, state.missingValue.value);
              }
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: Text("loading"));
            }
            if (state.isEmpty) {
              return EmptyChart();
            }
            if (state.isUpdating) {
              return Center(child: Text("updating"));
            }
            if (state.hasLoaded) {
              return renderStateLoaded(state.stat, counter, statBloc);
            }

            return Center(child: Text("last hope"));
          },
        ),
        bottomNavigationBar: ChartBottomAppBar(
          onBackPressed: statBloc.backPressed,
          onAddPressed: () => showMissingDatePicker(context, counter, statBloc.addMissingValue),
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

  Widget renderStateLoaded(List<HistoryModel> values, CounterItem counter, StatBloc statBloc) =>
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
                onValueChanged: (value) => statBloc.updateValue(values[index], value),
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
