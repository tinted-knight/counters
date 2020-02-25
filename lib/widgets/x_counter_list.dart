import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/pages/main/counters_state.dart';
import 'package:counter/views/main/ColoredSwipeable.dart';
import 'package:counter/views/main/counter_row/CounterRow.dart';
import 'package:flutter/material.dart';

class CounterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    return BlocStreamBuilder<CounterState>(
      bloc: countersBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.hasFailed) {
          return Center(child: Text("failed"));
        }
        return ListView.builder(
          itemCount: state.counters.length,
          itemBuilder: (context, index) {
            return ColoredSwipeable(
              onTap: () => navBloc.detailsOf(state.counters[index]),
              onSwiped: null,
              child: Column(
                children: <Widget>[
                  CounterRow(state.counters[index]),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
