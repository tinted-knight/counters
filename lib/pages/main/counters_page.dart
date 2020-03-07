import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/views/create/screen_create.dart';
import 'package:counter/views/main/ColoredSwipeable.dart';
import 'package:counter/views/main/counter_row/CounterRow.dart';
import 'package:flutter/material.dart';

import 'counters_bloc.dart';
import 'counters_state.dart';

class CountersPage extends StatelessWidget {
  const CountersPage({Key key, this.title}) : super(key: key);

  static const route = "/";

  final String title;

  @override
  Widget build(BuildContext context) {
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    return Scaffold(
      appBar: _appBar(context, countersBloc.reload),
      body: BlocStreamBuilder<CounterState>(
        bloc: countersBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.hasFailed) {
            return Center(child: Text("failed"));
          }
          if (state.isLoaded) {
            return ListView.builder(
              itemCount: state.counters.length,
              itemBuilder: (context, index) {
                return ColoredSwipeable(
                  onTap: () {
                    navBloc.detailsOf(state.counters[index]);
                  },
                  onSwiped: () => countersBloc.increment(index),
                  child: Column(
                    children: <Widget>[
                      CounterRow(state.counters[index]),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: Text("something has gone wrong"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(ScreenCreate.route),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _appBar(BuildContext context, Function onPressed) => PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: AppBar(
            actionsIconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Color(0xff212121),
                ),
            title: Text(
              title,
              style: TextStyle(color: Color(0xff212121)),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.autorenew),
                onPressed: onPressed,
              ),
              IconButton(
                icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
