import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/stat/stat_bloc.dart';
import 'package:counter/pages/stat/stat_state.dart';
import 'package:counter/views/details/chart_01.dart';
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
                    tabs: <Widget>[Text("Simple list"), Text("Chart")],
                    indicatorColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
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
              return TabBarView(
                children: [
                  ListView.builder(
                    itemCount: stat.length,
                    itemBuilder: (context, index) => listTile(
                      context,
                      stat[index],
                      counter,
                      (value) => statBloc.updateValue(counter, value),
                    ),
//              itemBuilder: (context, index) => listTile(stat[index], counter),
                  ),
                  Chart01(counter: counter, stat: stat),
                ],
              );
            }

            return Center(child: Text("last hope"));
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete_sweep),
                tooltip: "Clear history",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listTile2(HistoryModel entry, CounterItem counter) => ListTile(
        title: Text(entry.valueString),
        subtitle: Text(entry.dateString),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete),
        ),
      );

  Widget listTile(BuildContext context, HistoryModel entry, CounterItem counter,
      Function(String) onValueChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.valueString,
                      style: TextStyle(
                        color: entry.value > counter.goal
                            ? Colors.green
                            : entry.value == counter.goal ? Colors.blue : Colors.red,
                      ),
                    ),
                    Text(entry.dateString),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  final newValue = await inputDialog(context, entry);
                  onValueChanged(newValue);
                },
                color: Colors.black54,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Colors.black54,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  Future<String> inputDialog(BuildContext context, HistoryModel entry) async {
    String newValue;
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("it is title"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: "Current value",
            hintText: entry.valueString,
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("submit"),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
  }
}
