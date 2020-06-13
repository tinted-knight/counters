import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/i18n/app_localization.dart';
import 'package:counter/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'counter_list.dart';
import 'counters_bloc.dart';

class CountersPage extends StatefulWidget {
  const CountersPage({Key key}) : super(key: key);

  static const route = "/";

  @override
  _CountersPageState createState() => _CountersPageState();
}

class _CountersPageState extends State<CountersPage> with TickerProviderStateMixin {
  AnimationController _hideFabAnimation;

  String _appBarImage;

  static const double _appBarHeightModifier = 5.0;

  Function onScroll;

  @override
  void initState() {
    super.initState();

    _appBarImage = appBarBgImages[0];

    _hideFabAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _hideFabAnimation.forward();
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);
    countersBloc.loadCounters();

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: withSliverAppBar(),
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation,
          alignment: Alignment.center,
          child: FloatingActionButton(
            onPressed: () => navBloc.create(),
            child: Icon(
              Icons.add,
              color: ThemeLight.iconPrimary,
            ),
          ),
        ),
      ),
    );
  }

  NestedScrollView withSliverAppBar() {
    final lz = AppLocalization.of(context);

    return NestedScrollView(
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
      body: CounterList(),
    );
  }
}
