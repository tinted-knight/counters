import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterListBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

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
          //debug
//          state.values
//              .forEach((v) => print("${v.title}, v:${v.value}, g:${v.goal}"));
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
        return TestWidget(
          onTap: () => itemTap(items[index]),
          onSwiped: () => bloc.incrementCounter(items[index]),
          child: Column(
            children: <Widget>[
              CounterRow(items[index]),
              _divider(),
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
}

typedef OnSwiped = Function();

class TestWidget extends StatefulWidget {
  const TestWidget({
    Key key,
    @required this.child,
    @required this.onSwiped,
    @required this.onTap,
  }) : super(key: key);

  final Widget child;
  final OnSwiped onSwiped;
  final GestureTapCallback onTap;

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Color color;

  int _red = 255;
  int _green = 255;
  int _blue = 255;

  final _limit = 150;
  final _velocity = 500.0;

  @override
  void initState() {
    super.initState();
    color = Color.fromARGB(50, _red, _green, _blue);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onHorizontalDragUpdate: (details) {
        final delta = (details.delta.dx * 2).floor();
        final value = _red >= delta ? _red -= delta : _red = 0;
        setState(() {
          _red = value <= 255 ? value : 255;
          _blue = value <= 255 ? value : 255;
        });
      },
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx >= _velocity || _red <= _limit) {
          widget.onSwiped();
          setState(() {
            _red = 0;
            _blue = 0;
          });
        }
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
                color: color.withRed(_red).withGreen(_green).withBlue(_blue),
                padding: EdgeInsets.all(16.0)),
          ),
          widget.child,
        ],
      ),
    );
  }
}
