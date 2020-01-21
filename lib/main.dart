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
        "/": (context) => MyHomePage(
              title: 'Counter Prototype',
              storageProvider: storage,
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

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
    @required this.storageProvider,
  }) : super(key: key);

  final String title;
  final SQLiteStorageProvider storageProvider;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider(
        bloc: CounterListBloc(widget.storageProvider),
        child: Counters(
          itemTap: (item) => Navigator.of(context).pushNamed(
            ScreenDetails.route,
            arguments: item,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/create"),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
