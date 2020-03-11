import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
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
    print('main::build');
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    return Scaffold(
      appBar: _appBar(
        context,
        countersBloc.reload,
        onCreate: () => navBloc.create(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocStreamBuilder<CounterState>(
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
                        child: CounterRow(state.counters[index]),
                      );
                    },
                  );
                }
                return Center(child: Text("something has gone wrong"));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 40.0,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(),
                    color: Color(0xff00796b),
                    colorBrightness: Brightness.dark,
                    onPressed: () => navBloc.create(),
                    icon: Icon(Icons.add),
                    label: Text("Create"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context, Function onFlush, {Function onCreate}) => PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: AppBar(
            actionsIconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Color(0xff313131),
                ),
            title: Text(
              title,
              style: TextStyle(color: Color(0xff313131)),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                tooltip: "Flush counter | Reload all",
                icon: Icon(Icons.autorenew),
                onPressed: onFlush,
              ),
              IconButton(
                tooltip: "Gimme some heeeelp",
                icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
                onPressed: () {},
              ),
              IconButton(
                tooltip: "Create counter",
                icon: Icon(Icons.add),
                onPressed: onCreate,
              ),
            ],
          ),
        ),
      );
}
