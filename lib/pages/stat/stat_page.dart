import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/stat/stat_bloc.dart';
import 'package:counter/pages/stat/stat_state.dart';
import 'package:flutter/material.dart';

import '../../model/HistoryModel.dart';

class StatPage extends StatelessWidget {
  static const route = "/stat";

  @override
  Widget build(BuildContext context) {
    print("StatPage::build");

    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final StatBloc statBloc = BlocProvider.of<StatBloc>(context);
    statBloc.load(counter);

    return Scaffold(
      body: BlocStreamBuilder<StatState>(
        bloc: statBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: Text("loading"));
          }
          if (state.isEmpty) {
            return Center(child: Text("empty :("));
          }
          if (state.hasLoaded) {
            final stat = state.stat;
            return ListView.builder(
              itemCount: stat.length,
              itemBuilder: (context, index) => listTile(stat, index, counter),
            );
          }

          return Center(child: Text("last hope"));
        },
      ),
    );
  }

  Widget listTile(List<HistoryModel> data, int index, CounterItem counter) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data[index].valueString,
                  style: TextStyle(
                    color: data[index].value > counter.goal
                        ? Colors.green
                        : data[index].value == counter.goal ? Colors.blue : Colors.red,
                  ),
                ),
                Text(data[index].dateString),
              ],
            ),
          ),
          Divider(),
        ],
      );
}
