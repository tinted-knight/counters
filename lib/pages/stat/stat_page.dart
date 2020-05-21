import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/stat/stat_bloc.dart';
import 'package:counter/pages/stat/stat_state.dart';
import 'package:counter/views/stat/bar_chart.dart';
import 'package:counter/views/stat/stat_list_tile.dart';
import 'package:counter/widgets/dialogs/input_dialog.dart';
import 'package:counter/widgets/dialogs/yes_no_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/HistoryModel.dart';

class StatPage extends StatelessWidget {
  static const route = "/stat";

  @override
  Widget build(BuildContext context) {
    print("StatPage::build");

    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final StatBloc statBloc = BlocProvider.of<StatBloc>(context);
    statBloc.load(counter);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildTabBar(counter),
        body: BlocStreamBuilder<StatState>(
          bloc: statBloc,
          stateListener: (state) async {
            if (state.hasCanceled) navBloc.pop();

            if (state.itemExists) {
              final confirmed = await yesNoDialog(
                context,
                color: counter.colorValue,
                message: "The item already exists. Do you want to update it's value?",
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
              return Center(child: Text("empty :("));
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
        bottomNavigationBar: buildBottomAppBar(context, statBloc, counter),
      ),
    );
  }

  PreferredSize buildTabBar(CounterItem counter) => PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
//          color: ColorPalette.color(counter.colorIndex),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(child: Container()),
                TabBar(
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Chart"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("List"),
                    ),
                  ],
                  labelColor: Color(0xff212121),
                  indicator: _neumorphicInnerDecoration,
//                  indicator: BoxDecoration(
//                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                    color: counter.colorValue,
//                  ),
                ),
              ],
            ),
          ),
        ),
      );

  BoxDecoration get _neumorphicInnerDecoration => BoxDecoration(
        color: Colors.black.withOpacity(0.075),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(1, 1),
            blurRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );

  BottomAppBar buildBottomAppBar(BuildContext context, StatBloc statBloc, CounterItem counter) =>
      BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => statBloc.backPressed(),
            ),
            Expanded(child: SizedBox()),
            IconButton(
              icon: Icon(Icons.add),
              tooltip: "Add missing value",
              onPressed: () => _showDatePicker(context, statBloc, counter),
            ),
            IconButton(
              icon: Icon(Icons.delete_sweep),
              tooltip: "Clear history",
              onPressed: () {},
            ),
          ],
        ),
      );

  _showDatePicker(BuildContext context, StatBloc statBloc, CounterItem counter) async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2042),
    );
    if (dateTime != null) {
      final value = await inputDialog(context, hint: "", counter: counter);
      if (value != null) {
        statBloc.addMissingValue(
          counter: counter,
          value: value,
          dateTime: dateTime,
        );
//        }
      }
    }
  }

  Widget renderStateLoaded(List<HistoryModel> values, CounterItem counter, StatBloc statBloc) =>
      TabBarView(
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
      );
}
