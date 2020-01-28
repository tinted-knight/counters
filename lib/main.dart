import 'package:counter/bloc/AppBloc.dart';
import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterListBloc.dart';
import 'package:counter/bloc/CounterUpdateBloc.dart';
import 'package:counter/bloc/CreateCounterBloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/create/screen_create.dart';
import 'package:counter/views/details/screen_details.dart';
import 'package:flutter/material.dart';

import 'model/storage/LocalStorageProvider.dart';
import 'views/main/Counters.dart';
import 'views/main/screen_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final storage = SQLiteStorageProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counters',
      theme: themeLight,
      initialRoute: "/",
      routes: {
        Routes.root.path: (context) => BlocProvider(
              bloc: AppBloc(),
              child: MainScreen(
                title: 'Counter Prototype',
                storage: storage,
              ),
            ),
        Routes.details.path: (context) => BlocProvider(
              bloc: CounterUpdateBloc(storage),
              child: ScreenDetails(),
            ),
        Routes.create.path: (context) => BlocProvider<CreateCounterBloc>(
              bloc: CreateCounterBloc(storage),
              child: ScreenCreate(),
            ),
      },
    );
  }
}

enum Routes { root, details, create }

extension RoutesString on Routes {
  String get path {
    switch (this) {
      case Routes.root:
        return "/";
      case Routes.details:
        return "/details";
      case Routes.create:
        return "/create";
    }
  }
}
