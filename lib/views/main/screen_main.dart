import 'package:counter/bloc/AppBloc.dart';
import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterListBloc.dart';
import 'package:counter/model/storage/LocalStorageProvider.dart';
import 'package:counter/views/create/screen_create.dart';
import 'package:flutter/material.dart';

import 'MainBody.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
    this.title,
    @required this.storage,
  }) : super(key: key);

  static const route = "/";

  final String title;
  final SQLiteStorageProvider storage;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppBloc _appBloc;

  @override
  Widget build(BuildContext context) {
    _appBloc = BlocProvider.of<AppBloc>(context);
    final countersBloc = CounterListBloc(widget.storage);

    return Scaffold(
//      backgroundColor: Color(0xFFDFDDDD),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () => countersBloc.resetCounters(),
          ),
          IconButton(
            icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        bloc: countersBloc,
        child: MainBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(ScreenCreate.route),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
