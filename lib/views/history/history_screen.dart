import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class ScreenHistory extends StatelessWidget {
  static const route = "/history";

  @override
  Widget build(BuildContext context) {
    final CounterItem counter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: null,
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, position) {
          return null;
//          final entry = state.value[position];
//          final dt = DateTime.fromMillisecondsSinceEpoch(entry.date);
//          return ListTile(
//            title: Text(state.value[position].value.toString()),
//            subtitle: Text("month: ${dt.month}, day: ${dt.day}"),
//          );
        },
      ),
    );
  }
}
