import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/app_bloc/AppBloc.dart';
import 'package:counter/bloc/create_counter_bloc/CreateCounterBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/history_bloc/HistoryBloc.dart';
import 'package:counter/pages/create/create_page.dart';
import 'package:counter/pages/details/details_page.dart';
import 'package:counter/pages/details/single_bloc.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/history/history_screen.dart';
import 'package:flutter/material.dart';

import 'model/storage/LocalStorageProvider.dart';
import 'pages/main/counters_page.dart';

final appBloc = AppBloc();

void main() => runApp(BlocProvider(
      blocBuilder: () => appBloc,
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  final storage = SQLiteStorageProvider();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final navBloc = NavigatorBloc(navigatorKey: _navigatorKey);

    return BlocProvider(
      blocBuilder: () => navBloc,
      child: BlocProvider(
        blocBuilder: () => CountersBloc(repo: storage),
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Counters',
          theme: themeLight,
          initialRoute: CountersPage.route,
          routes: {
            CountersPage.route: (context) => CountersPage(title: 'YCounters'),
            DetailsPage.route: (context) => BlocProvider<SingleBloc>(
                  blocBuilder: () => SingleBloc(repo: storage),
                  child: DetailsPage(),
                ),
            CreatePage.route: (context) => BlocProvider<CreateCounterBloc>(
                  blocBuilder: () => CreateCounterBloc(storage),
                  child: CreatePage(),
                ),
            ScreenHistory.route: (context) => BlocProvider<HistoryBloc>(
                  blocBuilder: () => HistoryBloc(storage),
                  child: ScreenHistory(),
                ),
          },
        ),
      ),
    );
  }
}
