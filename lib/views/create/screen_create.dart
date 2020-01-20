import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CreateCounterBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/views/create/rows/ButtonRow.dart';
import 'package:counter/views/create/rows/PropertyRow.dart';
import 'package:flutter/material.dart';

class ScreenCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CreateCounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Create counter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline, semanticLabel: "Quick help"),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<CreateCounterState>(
        stream: counterBloc.states,
        initialData: CreateCounterState.idle,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case CreateCounterState.idle:
              return _content(context, counterBloc);
            case CreateCounterState.inprogress:
              return _content(context, counterBloc);
              break;
            case CreateCounterState.success:
              return _content(context, counterBloc);
              break;
            case CreateCounterState.error:
              return _content(context, counterBloc);
              break;
          }
          return null;
        },
      ),
//      body: _content(context, counterBloc),
    );
  }

  _content(BuildContext context, CreateCounterBloc counterBloc) {
    return LayoutBuilder(
      builder: (ctx, viewport) => Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewport.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    PropertyRow.title("Title"),
                    PropertyRow.step("Step"),
                    PropertyRow.goal("Goal"),
                    PropertyRow.unit("Unit"),
                    PropertyRow.color("Color"),
                    Expanded(
                        child: ButtonRow(
                      onCancel: () => Navigator.of(context).pop(),
                      onCreate: () => counterBloc.create(
                        counter: CounterItem(
                          title: "New counter",
                          value: 0,
                          goal: 101,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
