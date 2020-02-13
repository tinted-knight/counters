import 'package:counter/bloc/app_bloc/AppBloc.dart';
import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterUpdateBloc.dart';
import 'package:counter/bloc/CreateCounterBloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/create/screen_create.dart';
import 'package:counter/views/details/screen_details.dart';
import 'package:flutter/material.dart';

import 'model/storage/LocalStorageProvider.dart';
import 'views/main/screen_main.dart';

final appBloc = AppBloc();

void main() => runApp(BlocProvider(
      blocBuilder: () => appBloc,
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  final storage = SQLiteStorageProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counters',
      theme: themeLight,
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (context) => HomeScreen(
              title: 'Your Counters',
              storage: storage,
            ),
        ScreenDetails.route: (context) => BlocProvider(
              blocBuilder: () => CounterUpdateBloc(storage),
              child: ScreenDetails(),
            ),
        ScreenCreate.route: (context) => BlocProvider<CreateCounterBloc>(
              blocBuilder: () => CreateCounterBloc(storage),
              child: ScreenCreate(),
            ),
      },
    );
  }
}
