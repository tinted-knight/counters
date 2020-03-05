import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/views/create/rows/color_picker/ColorPicker.dart';
import 'package:counter/views/details/rows/ButtonRow.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/details/rows/StepRow.dart';
import 'package:counter/views/details/rows/UnitRow.dart';
import 'package:counter/views/details/rows/top_row/TopRow.dart';
import 'package:counter/widgets/action_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'single_bloc.dart';
import 'single_state.dart';

class DetailsOf extends StatefulWidget {
  const DetailsOf(this.counter, {Key key}) : super(key: key);

  final CounterItem counter;

  @override
  _DetailsOfState createState() => _DetailsOfState();
}

class _DetailsOfState extends State<DetailsOf> {
  SingleBloc singleBloc;
  CountersBloc countersBloc;
  NavigatorBloc navBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (countersBloc == null) countersBloc = BlocProvider.of<CountersBloc>(context);
    if (singleBloc == null) singleBloc = BlocProvider.of<SingleBloc>(context);
    if (navBloc == null) navBloc = BlocProvider.of<NavigatorBloc>(context);

    singleBloc.load(widget.counter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocStreamBuilder<SingleState>(
      bloc: singleBloc,
      stateListener: (state) {
        if (state.validationError) {
          _showMessage(context, "validation error");
          return;
        }
        if (state.hasDone) {
          navBloc.pop();
          countersBloc.reload();
          return;
        }
        if (state.hasCanceled) {
          navBloc.pop();
          return;
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.hasDone) return Container();

        return _buildLayout(state);
      },
    );
  }

  LayoutBuilder _buildLayout(SingleState state) {
    return LayoutBuilder(
      builder: (ctx, viewport) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewport.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _appBar(state),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 150.0,
                  child: TopRow(
                    value: state.counter.value,
                    goal: state.counter.goal,
                    controller: singleBloc.valueCtrl,
                    hasError: state.counterWithErrors?.hasValueError ?? false,
                    upButtonTap: () {
                      print('upButtonTap');
                    },
                    downButtonTap: () {
                      print('downButtonTap');
                    },
                  ),
                ),
                StepRow(
                  controller: singleBloc.stepCtrl,
                  hasError: state.counterWithErrors?.hasStepError ?? false,
                ),
                GoalRow(
                  controller: singleBloc.goalCtrl,
                  hasError: state.counterWithErrors?.hasGoalError ?? false,
                ),
                UnitRow(controller: singleBloc.unitCtrl),
                Expanded(
                  child: ButtonRow(
                    buttonColor: ColorPalette.bgColor(state.counter.colorIndex),
                    isSaving: state.isSaving,
                    onSave: () => singleBloc.update(),
                    onCancel: () => singleBloc.cancel(),
                    onStat: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(SingleState state) => AppBar(
        backgroundColor: ColorPalette.bgColor(state.counter.colorIndex),
        elevation: 4.0,
        title: TextField(
          controller: singleBloc.titleCtrl,
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        actions: <Widget>[
          ColorActionButton(
            inAction: false,
            onPressed: _showColorPicker,
          ),
          DeleteActionButton(
            inAction: state.isDeleting,
            onPressed: () => singleBloc.delete(state.counter),
          ),
          SaveActionButton(
            inAction: state.isSaving,
            onPressed: singleBloc.update,
          ),
        ],
      );

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: ColorPicker(
          selected: ColorPalette.blue,
          onColorPicked: (newColor) {
            singleBloc.applyColor(newColor);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String msg) {
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
