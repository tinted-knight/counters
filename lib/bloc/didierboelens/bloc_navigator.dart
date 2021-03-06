import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/chart/chart_page.dart';
import 'package:counter/pages/create/create_page.dart';
import 'package:counter/pages/details/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorBloc extends BlocEventStateBase<NavigatorAction, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({this.navigatorKey}) : super(initialState: NavigatorIdle());

  @override
  Stream eventHandler(NavigatorAction event, currentState) async* {
    if (event is NavigatorActionPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToHomeEvent) {
      navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
    } else if (event is NavigateToDetails) {
      navigatorKey.currentState.pushNamed(DetailsPage.route, arguments: event.item);
    } else if (event is NavigatorActionCreate) {
      navigatorKey.currentState.pushNamed(CreatePage.route);
    } else if (event is NavigateToStat) {
      navigatorKey.currentState.pushNamed(ChartPage.route, arguments: event.item);
    }
  }

  void detailsOf(CounterItem item) => fire(NavigateToDetails(item));

  void statOf(CounterItem item) => fire(NavigateToStat(item));

  void create() => fire(NavigatorActionCreate());

  void home() => fire(NavigateToHomeEvent());

  void pop() => fire(NavigatorActionPop());
}

class NavigatorAction {
  NavigatorAction();
}

class NavigatorIdle extends NavigatorAction {}

class NavigatorActionPop extends NavigatorAction {}

class NavigatorActionCreate extends NavigatorAction {}

class NavigateToHomeEvent extends NavigatorAction {}

class NavigateToDetails extends NavigatorAction {
  NavigateToDetails(this.item);

  final CounterItem item;
}

class NavigateToStat extends NavigatorAction {
  NavigateToStat(this.item);

  final CounterItem item;
}
