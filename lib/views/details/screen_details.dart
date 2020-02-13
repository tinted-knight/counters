import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/CounterUpdateBloc.dart';
import 'package:counter/bloc/StreamBuilderNav.dart';
import 'package:counter/bloc/app_bloc/AppBloc.dart';
import 'package:counter/bloc/app_bloc/app_actions.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/views/details/rows/ButtonRow.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/history/history_screen.dart';
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
  final _titleCtrl = TextEditingController();

  CounterUpdateBloc bloc;
  AppBloc appBloc;
  CounterItem counter;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<CounterUpdateBloc>(context);
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    counter = ModalRoute.of(context).settings.arguments;

    _valueCtrl.text = counter.value.toString();
    _stepCtrl.text = counter.step.toString();
    _goalCtrl.text = counter.goal.toString();
    _unitCtrl.text = counter.unit;
    _titleCtrl.text = counter.title;
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
                      child: TopRow(
                        value: counter.value,
                        goal: counter.goal,
                        controller: _valueCtrl,
                      ),
                      height: 120.0,
                    ),
                    SizedBox(height: 42.0),
                    StepRow(controller: _stepCtrl),
                    GoalRow(controller: _goalCtrl),
                    UnitRow(controller: _unitCtrl),
                    RedirectStreamBuilder(
                      listener: _navigationListener,
                      stream: bloc.states,
                      initialData: CounterDetailsState.idle(),
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

  void _navigationListener(CounterDetailsState state) {
    print('_navigationListener');
    if (state is StateUpdated) {
      Navigator.of(context).pop();
      appBloc.fire(action: AppActions.counterUpdated());
      return;
    }
    if (state is StateDeleted) {
      Navigator.of(context).pop();
      appBloc.fire(action: AppActions.counterDeleted());
      return;
    }
    if (state is StateHistory) {
      Navigator.of(context).pushNamed(ScreenHistory.route, arguments: counter);
      return;
    }
  }

  Widget _buildButtonRow(BuildContext context, AsyncSnapshot<CounterDetailsState> snapshot) {
    print('_buildButtonRow');
    if (snapshot.data is StateIdle) {
      return Expanded(child: ButtonRow(
        onClick: (type) {
          switch (type) {
            case ButtonType.delete:
              bloc.btnHistoryClick(counter);
              break;
            case ButtonType.cancel:
              bloc.btnCancelClick();
              break;
            case ButtonType.save:
              _btnSaveClick();
              break;
          }
        },
      ));
    }
    if (snapshot.data is StateInprogress) {
      return CircularProgressIndicator();
    }
    if (snapshot.data is StateError) {
      //todo
    }
    if (snapshot.data is StateUpdated) {
      return Expanded(child: Center(child: Text("")));
    }
    if (snapshot.data is StateDeleted) {
      return Expanded(child: Center(child: Text("")));
    }
    return Expanded(child: Center(child: Text("")));
  }

  void _btnSaveClick() {
    bloc.btnSaveClick(
      counter,
      title: _titleCtrl.text,
      value: _valueCtrl.text,
      step: _stepCtrl.text,
      goal: _goalCtrl.text,
      unit: _unitCtrl.text,
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: ColorPalette.bgColor(counter.colorIndex),
      elevation: 0.0,
      title: TextField(
        controller: _titleCtrl,
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete, semanticLabel: "Delete"),
          onPressed: () {
            bloc.btnDeleteClick(counter);
          },
        ),
        IconButton(
          icon: Icon(Icons.help_outline, semanticLabel: "Help"),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.save, semanticLabel: "Save"),
          onPressed: _btnSaveClick,
        ),
      ],
    );
  }
}
