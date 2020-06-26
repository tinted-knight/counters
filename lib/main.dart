import 'package:counter/bloc/app_bloc.dart';
import 'package:counter/bloc/app_state.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/i18n/app_localization.dart';
import 'package:counter/pages/chart/chart_bloc.dart';
import 'package:counter/pages/chart/chart_page.dart';
import 'package:counter/pages/create/create_bloc.dart';
import 'package:counter/pages/create/create_page.dart';
import 'package:counter/pages/details/details_bloc.dart';
import 'package:counter/pages/details/details_page.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/pages/splash/splash_page.dart';
import 'package:counter/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'model/storage/LocalStorageProvider.dart';
import 'pages/main/counters_page.dart';

void main() => runApp(CountersApp());

class CountersApp extends StatelessWidget {
  final repository = SQLiteStorageProvider();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final navBloc = NavigatorBloc(navigatorKey: _navigatorKey);
    final appBloc = AppBloc()..loadPrefs();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0x33000000),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: ThemeLight.scaffoldBgColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return BlocProvider(
      blocBuilder: () => appBloc,
      child: BlocProvider(
        blocBuilder: () => navBloc,
        child: BlocProvider(
          blocBuilder: () => CountersBloc(repo: repository),
          child: MaterialApp(
            onGenerateTitle: (context) => AppLocalization.of(context).appTitle,
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''),
              Locale('ru', ''),
            ],
            navigatorKey: _navigatorKey,
            theme: themeLight,
            initialRoute: CountersPage.route,
            routes: {
              CountersPage.route: (context) {
                return BlocStreamBuilder<AppState>(
                  bloc: appBloc,
                  builder: (ctx, state) {
                    if (state is AppStateLoading) return SplashPage();

                    return CountersPage();
                  },
                );
              },
              DetailsPage.route: (context) => BlocProvider<DetailsBloc>(
                    blocBuilder: () => DetailsBloc(repo: repository),
                    child: DetailsPage(),
                  ),
              CreatePage.route: (context) => BlocProvider<CreateBloc>(
                    blocBuilder: () => CreateBloc(repository),
                    child: CreatePage(),
                  ),
              ChartPage.route: (context) => BlocProvider<ChartBloc>(
                    blocBuilder: () => ChartBloc(repository),
                    child: ChartPage(),
                  ),
            },
          ),
        ),
      ),
    );
  }
}
