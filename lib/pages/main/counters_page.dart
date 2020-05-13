import 'package:counter/bloc/app_bloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/main/ColoredSwipeable.dart';
import 'package:counter/views/main/counter_row/CounterRow.dart';
import 'package:counter/views/main/counter_row/non_swipeable/counter_row_non_swipeable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'counters_bloc.dart';
import 'counters_state.dart';

class CountersPage extends StatefulWidget {
  const CountersPage({Key key, this.title, this.isSwipeable}) : super(key: key);

  static const route = "/";

  final String title;
  final bool isSwipeable;

  @override
  _CountersPageState createState() => _CountersPageState();
}

class _CountersPageState extends State<CountersPage> {
  bool _isVisible = true;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.idle:
          // TODO: Handle this case.
          break;
        case ScrollDirection.forward:
          if (!_isVisible)
            setState(() {
              _isVisible = true;
            });
          break;
        case ScrollDirection.reverse:
          if (_isVisible)
            setState(() {
              _isVisible = false;
            });

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);

    return Scaffold(
//      appBar: _appBar(
//        context,
//        appBloc,
//        onCreate: () => navBloc.create(),
//      ),
      body: withSliverAppBar(appBloc, navBloc, countersBloc),
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              onPressed: () => navBloc.create(),
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  NestedScrollView withSliverAppBar(
      AppBloc appBloc, NavigatorBloc navBloc, CountersBloc countersBloc) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.title,
                style: TextStyle(color: Color(0xff313131)),
              ),
            ),
            backgroundColor: ThemeLight.appbarColor,
            elevation: 0.0,
          )
        ];
      },
      body: counters(countersBloc, navBloc),
    );
  }

  Column counters(CountersBloc countersBloc, NavigatorBloc navBloc) {
    return Column(
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
                    return widget.isSwipeable
                        ? _swipeable(
                            counter: state.counters[index],
                            onTap: () => navBloc.detailsOf(state.counters[index]),
                            onSwiped: () => countersBloc.stepUp(index),
                          )
                        : _nonSwipeable(
                            context,
                            counter: state.counters[index],
                            onTap: () => navBloc.detailsOf(state.counters[index]),
                            onIncrement: () => countersBloc.stepUp(index),
                            onDecrement: () => countersBloc.stepDown(index),
                          );
                  },
                );
              }
              return Center(child: Text("something has gone wrong"));
            },
          ),
        ),
//@deprecated wide "New counter" button at the bottom of the screen
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  height: 60.0,
//                  child: RaisedButton.icon(
//                    shape: RoundedRectangleBorder(),
//                    color: Color(0xff00796b),
//                    colorBrightness: Brightness.dark,
//                    onPressed: () => navBloc.create(),
//                    icon: Icon(Icons.add),
//                    label: Text("Create"),
//                  ),
//                ),
//              ),
//            ],
//          ),
      ],
    );
  }

  Widget _swipeable({CounterItem counter, Function onTap, Function onSwiped}) => ColoredSwipeable(
        onTap: onTap,
        onSwiped: onSwiped,
        child: CounterRow(counter),
      );

  Widget _nonSwipeable(BuildContext context,
      {CounterItem counter, Function onTap, Function onIncrement, Function onDecrement}) {
    return CounterRowNonSwipeable(
      counter,
      onTap: onTap,
      onIncrement: () {
        HapticFeedback.selectionClick();
        onIncrement();
      },
      onDecrement: onDecrement,
    );
  }

  Widget _appBar(BuildContext context, AppBloc appBloc, {Function onCreate}) => PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: AppBar(
            actionsIconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Color(0xff313131),
                ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(color: Color(0xff313131)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "(or not if you don't want to 🐶, just keep calm)",
                    style: TextStyle(color: Color(0x77313131), fontSize: 10),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                tooltip: "Switch swipeable",
                icon: Icon(widget.isSwipeable ? Icons.remove : Icons.add),
                onPressed: appBloc.switchSwipeable,
              ),
//              IconButton(
//                tooltip: "Gimme some heeeelp",
//                icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
//                onPressed: () {},
//              ),
              IconButton(
                tooltip: "Create counter",
                color: Colors.redAccent,
                icon: Icon(Icons.add_box),
                onPressed: onCreate,
              ),
            ],
          ),
        ),
      );
}
