import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterListBloc.dart';
import 'package:counter/bloc/CreateCounterBloc.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/create/screen_create.dart';
import 'package:counter/views/details/screen_details.dart';
import 'package:flutter/material.dart';

import 'model/CounterModel.dart';
import 'views/main/Counters.dart';
import 'model/storage/LocalStorageProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counters',
      theme: themeLight,
      home: MyHomePage(
        title: 'Counter Prototype',
        storageProvider: SQLiteStorageProvider(),
      ),
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
  List<CounterItem> items = [
    CounterItem(
      title: "Приседания",
      value: 15,
      goal: 100,
      unit: "kilograms",
      colorIndex: ColorPalette.blue,
    ),
    CounterItem(
      title: "Aquadetrim",
      value: 4000,
      goal: 4000,
      unit: "ME",
      colorIndex: ColorPalette.yellow,
    ),
    CounterItem(
      title: "Отжимания",
      value: 30,
      goal: 50,
      unit: "раз",
      colorIndex: ColorPalette.red,
    ),
  ];

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
          itemTap: (item) => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ScreenDetails(item)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => BlocProvider<CreateCounterBloc>(
              bloc: CreateCounterBloc(widget.storageProvider),
              child: ScreenCreate(),
            ),
          ),
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
