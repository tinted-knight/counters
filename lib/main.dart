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
        "/": (context) => BlocProvider(
          bloc: CounterListBloc(storage),
          child: MainScreen(
                title: 'Counter Prototype',
                storageProvider: storage,
              ),
        ),
        "/details": (context) => BlocProvider(
              bloc: CounterUpdateBloc(storage),
              child: ScreenDetails(),
            ),
        "/create": (context) => BlocProvider<CreateCounterBloc>(
              bloc: CreateCounterBloc(storage),
              child: ScreenCreate(),
            ),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
    this.title,
    @required this.storageProvider,
  }) : super(key: key);

  final String title;
  final SQLiteStorageProvider storageProvider;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
            onPressed: () {},
          ),
        ],
      ),
      body: Counters(
        itemTap: (item) => Navigator.of(context).pushNamed(
          ScreenDetails.route,
          arguments: item,
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).pushNamed("/create");
            switch (result) {
              case CreateResult.counter_created:
                _showMessage(context, result.toString());
                bloc.reloadCounters();
                break;
              case CreateResult.canceled:
                _showMessage(context, result.toString());
                break;
            }
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  _showMessage(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
