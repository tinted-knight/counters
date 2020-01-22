import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterUpdateBloc.dart';
import 'package:counter/bloc/StreamBuilderNav.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/views/details/rows/ButtonRow.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:flutter/material.dart';

import 'rows/ButtonRow.dart';
import 'rows/StepRow.dart';
import 'rows/TopRow.dart';
import 'rows/UnitRow.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({Key key}) : super(key: key);

  static const route = "/details";

  @override
  _ScreenDetailsState createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  final _valueCtrl = TextEditingController();
  final _stepCtrl = TextEditingController();
  final _goalCtrl = TextEditingController();
  final _unitCtrl = TextEditingController();

  CounterUpdateBloc bloc;
  CounterItem counter;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<CounterUpdateBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    counter = ModalRoute.of(context).settings.arguments;

    _valueCtrl.text = counter.value.toString();
    _stepCtrl.text = counter.step.toString();
    _goalCtrl.text = counter.goal.toString();
    _unitCtrl.text = counter.unit;
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _stepCtrl.dispose();
    _goalCtrl.dispose();
    _unitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return LayoutBuilder(
      builder: (ctx, viewport) => Stack(
        children: <Widget>[
          Hero(
            tag: counter.id,
            child: Container(color: ColorPalette.bgColor(counter.colorIndex)),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewport.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      child: TopRow(controller: _valueCtrl),
                      height: 120.0,
                    ),
                    SizedBox(height: 42.0),
                    StepRow(controller: _stepCtrl),
                    GoalRow(controller: _goalCtrl),
                    UnitRow(controller: _unitCtrl),
                    BlocStreamBuilder<CounterUpdateStates>(
                      listener: (state) {
                        if (state == CounterUpdateStates.doneEditing)
                          Navigator.of(context).pop();
                      },
                      stream: bloc.states,
                      initialData: CounterUpdateStates.idle,
                      builder: _buildButtonRow,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(
      BuildContext context, AsyncSnapshot<CounterUpdateStates> snapshot) {
    if (snapshot.data == CounterUpdateStates.idle) {
      return Expanded(child: ButtonRow(
        onClick: (type) {
          switch (type) {
            case ButtonType.delete:
              // TODO: Handle this case.
              break;
            case ButtonType.cancel:
              bloc.btnCancelClick();
              break;
            case ButtonType.save:
              bloc.btnSaveClick(
                counter,
                value: _valueCtrl.text,
                step: _stepCtrl.text,
                goal: _goalCtrl.text,
                unit: _unitCtrl.text,
              );
              break;
          }
        },
      ));
    }
    if (snapshot.data == CounterUpdateStates.inprogress) {
      return CircularProgressIndicator();
    }
    if (snapshot.data == CounterUpdateStates.error) {
      //todo
    }
    if (snapshot.data == CounterUpdateStates.doneEditing) {
      return Expanded(child: Center(child: Text("success")));
    }
    return Expanded(child: Center(child: Text("null")));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: ColorPalette.bgColor(counter.colorIndex),
      elevation: 0.0,
      title: Text(counter.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.help_outline, semanticLabel: "Help"),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.save, semanticLabel: "Save"),
          onPressed: () {},
        ),
      ],
    );
  }
}
