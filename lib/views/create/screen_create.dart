import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CreateCounterBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/views/create/rows/ButtonRow.dart';
import 'package:counter/views/create/rows/PropertyRow.dart';
import 'package:flutter/material.dart';

class ScreenCreate extends StatefulWidget {
  @override
  _ScreenCreateState createState() => _ScreenCreateState();
}

class _ScreenCreateState extends State<ScreenCreate> {
  final _titleCtrl = TextEditingController();
  final _stepCtrl = TextEditingController();
  final _goalCtrl = TextEditingController();
  final _unitCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _stepCtrl.dispose();
    _goalCtrl.dispose();
    _unitCtrl.dispose();
  }

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
                    PropertyRow.title("Title", _titleCtrl),
                    PropertyRow.step("Step", _stepCtrl),
                    PropertyRow.goal("Goal", _goalCtrl),
                    PropertyRow.unit("Unit", _unitCtrl),
                    PropertyRow.color("Color"),
                    Expanded(
                        child: ButtonRow(
                      onCancel: () => Navigator.of(context).pop(),
                      onCreate: () => counterBloc.create(
                        title: _titleCtrl.text,
                        step: _stepCtrl.text,
                        goal: _goalCtrl.text,
                        unit: _unitCtrl.text,
                      ),
//                      onCreate: () {
//                        print("saving");
//                        print("title:${_titleCtrl.text}");
//                        print("step:${_stepCtrl.text}");
//                        print("goal:${_goalCtrl.text}");
//                        print("unit:${_unitCtrl.text}");
//                      },
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
