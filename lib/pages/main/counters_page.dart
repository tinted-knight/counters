import 'package:counter/bloc/app_bloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/i18n/app_localization.dart';
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

  String _appBarImage;

  static const double _appBarHeightModifier = 5.0;

  @override
  void initState() {
    super.initState();

    _appBarImage = appBarBgImages[0];

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
      body: withSliverAppBar(appBloc, navBloc, countersBloc),
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              onPressed: () => navBloc.create(),
              child: Icon(
                Icons.add,
                color: ThemeLight.iconPrimary,
              ),
            )
          : null,
    );
  }

  NestedScrollView withSliverAppBar(
      AppBloc appBloc, NavigatorBloc navBloc, CountersBloc countersBloc) {
    final lz = AppLocalization.of(context);

    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / _appBarHeightModifier,
            floating: false,
            pinned: true,
            snap: false,
            backgroundColor: ThemeLight.appbarColor,
            elevation: 2.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.asset(
                "assets/images/$_appBarImage",
                colorBlendMode: BlendMode.darken,
                color: ThemeLight.scaffoldBgColor,
              ),
              title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: lz.motivational1,
                    style: TextStyle(color: Color(0xff313131)),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: lz.motivational2,
                    style: TextStyle(
                      color: Color(0xff313131),
                      fontSize: 10.0,
                    ),
                  )
                ]),
              ),
            ),
          ),
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
              if (state is CounterStateLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is CounterStateFailed) {
                return Center(child: Text("failed"));
              }
              if (state is CounterStateLoaded) {
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
}
