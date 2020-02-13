import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterListBloc.dart';
import 'package:counter/bloc/StreamBuilderNav.dart';
import 'package:counter/bloc/app_bloc/AppBloc.dart';
import 'package:counter/bloc/app_bloc/app_states.dart';
import 'package:counter/views/details/screen_details.dart';
import 'package:flutter/material.dart';

import 'Counters.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final countersBloc = BlocProvider.of<CounterListBloc>(context);

    return RedirectStreamBuilder<AppStates>(
        listener: (appState) {
          if (appState is StateActionMessage) {
            _showMessage(context, appState.msg);
            return;
          }
          if (appState is StateCounterCreated) {
            countersBloc.reloadCounters();
            _showMessage(context, "counter created");
            return;
          }
          if (appState is StateCounterDeleted) {
            countersBloc.reloadCounters();
            _showMessage(context, "counter deleted");
          }
          if (appState is StateCounterUpdated) {
            countersBloc.reloadCounters();
            _showMessage(context, "counter updated");
          }
        },
        stream: appBloc.states,
        initialData: StateIdle(),
        builder: (context, snapshot) {
          return BlocProvider(
            blocBuilder: () => countersBloc,
            child: Counters(
              itemTap: (item) => Navigator.of(context).pushNamed(
                ScreenDetails.route,
                arguments: item,
              ),
            ),
          );
        });
  }

  _showMessage(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(msg),
          ],
        ),
      ),
    );
  }
}
