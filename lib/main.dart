import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/app_bloc/AppBloc.dart';
import 'package:counter/bloc/create_counter_bloc/CreateCounterBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/history_bloc/HistoryBloc.dart';
import 'package:counter/pages/details/counter_bloc.dart';
import 'package:counter/pages/details/details_page.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/create/screen_create.dart';
import 'package:counter/views/details/screen_details.dart';
import 'package:counter/views/history/history_screen.dart';
import 'package:flutter/material.dart';

import 'model/storage/LocalStorageProvider.dart';
import 'pages/main/counters_page.dart';
import 'views/main/screen_main.dart';

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
          initialRoute: HomeScreen.route,
          routes: {
            CountersPage.route: (context) => CountersPage(title: 'YCounters'),
//            ScreenDetails.route: (context) => DetailsPage(),
            ScreenDetails.route: (context) => BlocProvider(
                  blocBuilder: () => SingleCounterBloc(repo: storage),
                  child: DetailsPage(),
                ),
            ScreenCreate.route: (context) => BlocProvider<CreateCounterBloc>(
                  blocBuilder: () => CreateCounterBloc(storage),
                  child: ScreenCreate(),
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
