import 'package:counter/model/ColorPalette.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:flutter/material.dart';

import 'model/CounterModel.dart';
import 'views/main/Counters.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counters',
      theme: themeDark,
      home: MyHomePage(title: 'Counter Prototype'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CounterItem> items = [
    CounterItem(
      title: "Приседания",
      value: 15,
      isGoalReached: false,
      unit: "kilograms",
      colorIndex: ColorPalette.blue,
    ),
    CounterItem(
      title: "Aquadetrim",
      value: 4000,
      isGoalReached: true,
      unit: "ME",
      colorIndex: ColorPalette.yellow,
    ),
    CounterItem(
      title: "Отжимания",
      value: 30,
      isGoalReached: false,
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
      body: Counters(items: items),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
