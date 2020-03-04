import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/views/details/rows/ButtonRow.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/details/rows/StepRow.dart';
import 'package:counter/views/details/rows/UnitRow.dart';
import 'package:counter/views/details/rows/top_row/TopRow.dart';
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
        if (state.hasSaved) {
          navBloc.pop();
          countersBloc.reload();
        }
        if (state.hasCanceled) {
          navBloc.pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.hasSaved) return Container();

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
                AppBar(
                  backgroundColor: ColorPalette.bgColor(widget.counter.colorIndex),
                  elevation: 0.0,
                  title: TextField(
                    controller: singleBloc.titleCtrl,
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete, semanticLabel: "Delete"),
                      onPressed: () {
//            counterBloc.btnDeleteClick(counter);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.show_chart, semanticLabel: "Help"),
//          onPressed: _btnShowHistoryClick,
                    ),
                    IconButton(
                      icon: Icon(Icons.save, semanticLabel: "Save"),
                      onPressed: singleBloc.update,
                    ),
                  ],
                ),
                SizedBox(
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
                  height: 150.0,
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
