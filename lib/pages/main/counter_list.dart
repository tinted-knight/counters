import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/widgets/debug_error_message.dart';
import 'package:counter/widgets/main/counter_list_empty.dart';
import 'package:counter/widgets/main/counter_row/non_swipeable/counter_row_non_swipeable.dart';
import 'package:flutter/material.dart';

import 'counters_bloc.dart';
import 'counters_state.dart';

class CounterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: BlocStreamBuilder<CounterState>(
            bloc: countersBloc,
            builder: (context, state) {
              if (state is CounterStateLoading) return Center(child: CircularProgressIndicator());

              if (state is CounterStateFailed) return YouShouldNotSeeThis();

              if (state is CounterStateEmpty) return CounterListEmpty(onTap: navBloc.create);

              if (state is CounterStateLoaded) {
                return ListView.builder(
                  itemCount: state.counters.length,
                  itemBuilder: (context, index) => CounterRowNonSwipeable(
                    state.counters[index],
                    onTap: () => navBloc.detailsOf(state.counters[index]),
                    onIncrement: () => countersBloc.stepUp(index),
                    onDecrement: () => countersBloc.stepDown(index),
                  ),
                );
              }
              return YouShouldNotSeeThis();
            },
          ),
        ),
      ],
    );
  }
}
