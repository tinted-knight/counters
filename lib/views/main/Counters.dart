import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterListBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

import 'ColoredSwipeable.dart';
import 'counter_row/CounterRow.dart';

class Counters extends StatelessWidget {
  const Counters({
    Key key,
    this.itemTap,
  }) : super(key: key);

  final Function(CounterItem item) itemTap;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterListBloc>(context);

    return StreamBuilder<CounterListStates>(
      stream: bloc.states,
      initialData: StateLoading(),
      builder: (context, snapshot) {
        if (snapshot.data is StateLoading) {
          return CircularProgressIndicator();
        }
        if (snapshot.data is StateValues) {
          final state = snapshot.data as StateValues;
          return _renderValues(state.values, bloc);
        }
        if (snapshot.data is StateEmpty) {
          return _renderEmpty();
        }
        return _renderError();
      },
    );
  }

  _renderValues(List<CounterItem> items, CounterListBloc bloc) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        return ColoredSwipeable(
          onTap: () => itemTap(items[index]),
          onSwiped: () => bloc.incrementCounter(items[index]),
          child: Column(
            children: <Widget>[
              CounterRow(items[index]),
//              _divider(),
            ],
          ),
        );
      },
    );
  }

  _renderEmpty() => Center(child: Text("empty stub"));

  _renderError() => Center(child: Text("error stub"));

  _divider() => Container(
        height: 1.0,
        margin: EdgeInsets.only(left: 32.0, right: 32.0),
        color: Colors.black12,
      );

  _showMessage(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
