import 'package:counter/bloc/app_bloc/AppBloc.dart';
import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/counter_list_bloc/CounterListBloc.dart';
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
//      backgroundColor: Color(0xFFF5F5F5),
      appBar: _appBar(countersBloc.resetCounters),
      body: BlocProvider(
        blocBuilder: () => countersBloc,
        child: MainBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(ScreenCreate.route),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _appBar(Function onPressed) => PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: AppBar(
            actionsIconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Color(0xff212121),
                ),
            title: Text(
              widget.title,
              style: TextStyle(color: Color(0xff212121)),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.autorenew),
                onPressed: onPressed,
              ),
              IconButton(
                icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
