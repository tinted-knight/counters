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
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

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
        bloc: CounterListBloc(widget.storage),
        child: MainBody(),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final result =
                await Navigator.of(context).pushNamed(ScreenCreate.route);
            switch (result) {
              case CreateResult.counter_created:
                appBloc.actions.add(AppActions.counterCreated(null));
                break;
              case CreateResult.canceled:
                appBloc.actions.add(AppActions.creationCanceled());
                break;
            }
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
