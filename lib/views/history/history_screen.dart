import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/bloc_state_builder.dart';
import 'package:counter/bloc/history_bloc/HistoryBloc.dart';
import 'package:counter/bloc/history_bloc/history_bloc_states.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class ScreenHistory extends StatelessWidget {
  static const route = "/history";

  @override
  Widget build(BuildContext context) {
    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    historyBloc.historyFor(counter: counter);

    return Scaffold(
      appBar: null,
      body: BlocStateBuilder(
        bloc: historyBloc,
        // ignore: missing_return
        builder: (BuildContext context, HistoryState state) {
          if (state is HistoryStateLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HistoryStateError) {
            return Center(child: Text("error"));
          }
          if (state is HistoryStateValues) {
            return ListView.builder(
              itemCount: state.value.length,
              itemBuilder: (context, position) {
                final entry = state.value[position];
                final dt = DateTime.fromMillisecondsSinceEpoch(entry.date);
                return ListTile(
                  title: Text(state.value[position].value.toString()),
                  subtitle: Text("month: ${dt.month}, day: ${dt.day}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
