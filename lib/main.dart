import 'package:counter/bloc/app_bloc.dart';
import 'package:counter/bloc/app_state.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/pages/create/create_bloc.dart';
import 'package:counter/pages/create/create_page.dart';
import 'package:counter/pages/details/details_page.dart';
import 'package:counter/pages/details/single_bloc.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/pages/splash/splash_page.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

import 'model/storage/LocalStorageProvider.dart';
import 'pages/main/counters_page.dart';

void main() => runApp(CountersApp());

class CountersApp extends StatelessWidget {
  final storage = SQLiteStorageProvider();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final navBloc = NavigatorBloc(navigatorKey: _navigatorKey);
    final appBloc = AppBloc();

    return BlocProvider(
      blocBuilder: () => appBloc,
      child: BlocProvider(
        blocBuilder: () => navBloc,
        child: BlocProvider(
          blocBuilder: () => CountersBloc(repo: storage),
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            title: 'Counters',
            theme: themeLight,
            initialRoute: CountersPage.route,
            routes: {
              CountersPage.route: (context) => BlocStreamBuilder<AppState>(
                    bloc: appBloc,
                    builder: (ctx, state) {
                      if (state.isLoading) return SplashPage();

                      return CountersPage(
                        title: "Try to keep up the rythm",
                        isSwipeable: state.isSwipeable,
                      );
                    },
                  ),
              DetailsPage.route: (context) => BlocProvider<DetailsBloc>(
                    blocBuilder: () => DetailsBloc(repo: storage),
                    child: DetailsPage(),
                  ),
              CreatePage.route: (context) => BlocProvider<CreateBloc>(
                    blocBuilder: () => CreateBloc(storage),
                    child: CreatePage(),
                  ),
//            ScreenHistory.route: (context) => BlocProvider<HistoryBloc>(
//                  blocBuilder: () => HistoryBloc(storage),
//                  child: ScreenHistory(),
//                ),
            },
          ),
        ),
      ),
    );
  }
}
