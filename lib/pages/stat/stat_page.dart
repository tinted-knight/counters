import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/stat/stat_bloc.dart';
import 'package:counter/pages/stat/stat_state.dart';
import 'package:counter/views/details/chart_bezier.dart';
import 'package:counter/views/stat/stat_list_tile.dart';
import 'package:flutter/material.dart';

import '../../model/HistoryModel.dart';
import 'input_dialog_mixin.dart';

class StatPage extends StatelessWidget with InputDialogMixin {
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: ColorPalette.color(counter.colorIndex),
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
                        child: Text("Simple list"),
                      ),
                    ],
                    indicatorColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocStreamBuilder<StatState>(
          bloc: statBloc,
          stateListener: (state) {
            if (state.hasCanceled) navBloc.pop();
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: Text("loading"));
            }
            if (state.isEmpty) {
              return Center(child: Text("empty :("));
            }
            if (state.hasLoaded) {
              return renderStateLoaded(state.stat, counter, statBloc);
            }

            return Center(child: Text("last hope"));
          },
        ),
        bottomNavigationBar: buildBottomAppBar(statBloc),
      ),
    );
  }

  BottomAppBar buildBottomAppBar(StatBloc statBloc) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => statBloc.backPressed(),
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

  Widget renderStateLoaded(List<HistoryModel> values, CounterItem counter, StatBloc statBloc) =>
      TabBarView(
        children: [
          BezierStatChart(
            values: values,
            lineColor: counter.colorValue,
          ),
          ListView.builder(
            itemCount: values.length,
            itemBuilder: (context, index) => StatListTile(
              entry: values[index],
              counter: counter,
              onValueChanged: (value) => statBloc.updateValue(counter, value),
              onEditTap: (entry) => inputDialog(context, entry),
            ),
          ),
        ],
      );
}
