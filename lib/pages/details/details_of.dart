import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/details/rows/StepRow.dart';
import 'package:counter/views/details/rows/UnitRow.dart';
import 'package:counter/views/details/rows/top_row/TopRow.dart';
import 'package:counter/widgets/action_buttons.dart';
import 'package:counter/widgets/color_picker/ColorPicker.dart';
import 'package:counter/widgets/saving_modal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/helper_functions.dart';
import 'single_bloc.dart';
import 'single_state.dart';

class DetailsOf extends StatefulWidget {
  const DetailsOf({Key key}) : super(key: key);

  @override
  _DetailsOfState createState() => _DetailsOfState();
}

class _DetailsOfState extends State<DetailsOf> {
  DetailsBloc detailsBloc;
  CountersBloc countersBloc;
  NavigatorBloc navBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (countersBloc == null) countersBloc = BlocProvider.of<CountersBloc>(context);
    if (detailsBloc == null) detailsBloc = BlocProvider.of<DetailsBloc>(context);
    if (navBloc == null) navBloc = BlocProvider.of<NavigatorBloc>(context);

//    singleBloc.load(widget.counter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocStreamBuilder<DetailsState>(
      bloc: detailsBloc,
      stateListener: (state) async {
        if (state.validationError) {
          _showMessage(context, "validation error");
          return;
        }
        if (state.hasDone) {
          countersBloc.reload();
          navBloc.home();
          return;
        }
        if (state.hasCanceled) {
          _goBackAndSaveIfNeeded(state);
          return;
        }
        if (state.colorHasUpdated) {
          countersBloc.singleUpdated(state.counter);
          Navigator.of(context).pop();
          return;
        }
        if (state.isSaving) {
          showSavingDialog(context, accent: ColorPalette.color(state.counter.colorIndex));
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

  LayoutBuilder _buildLayout(DetailsState state) {
    return LayoutBuilder(
      builder: (ctx, viewport) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewport.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _newAppBar(state),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 150.0,
                  child: TopRow(
                    value: state.counter.value,
                    goal: state.counter.goal,
                    controller: detailsBloc.valueCtrl,
                    hasError: state.counterWithErrors?.hasValueError ?? false,
                    upButtonTap: () {
                      detailsBloc.stepUp();
                    },
                    downButtonTap: () {
                      detailsBloc.stepDown();
                    },
                  ),
                ),
                StepRow(
                  controller: detailsBloc.stepCtrl,
                  hasError: state.counterWithErrors?.hasStepError ?? false,
                ),
                GoalRow(
                  controller: detailsBloc.goalCtrl,
                  hasError: state.counterWithErrors?.hasGoalError ?? false,
                ),
                UnitRow(controller: detailsBloc.unitCtrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _newAppBar(DetailsState state) => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPalette.bgColor(state.counter.colorIndex),
        elevation: 4.0,
        title: TextField(
          controller: detailsBloc.titleCtrl,
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        actions: <Widget>[
          ColorActionButton(
            inAction: false,
            onPressed: _showColorPicker,
          ),
          DeleteActionButton(
            inAction: state.isDeleting,
            onPressed: () => detailsBloc.delete(state.counter),
          ),
        ],
      );

  /// @deprecated -> [_newAppBar]
  AppBar _appBar(DetailsState state) => AppBar(
        backgroundColor: ColorPalette.bgColor(state.counter.colorIndex),
        elevation: 4.0,
        title: TextField(
          controller: detailsBloc.titleCtrl,
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        actions: <Widget>[
          ColorActionButton(
            inAction: false,
            onPressed: _showColorPicker,
          ),
          DeleteActionButton(
            inAction: state.isDeleting,
            onPressed: () => detailsBloc.delete(state.counter),
          ),
          SaveActionButton(
            inAction: state.isSaving,
            onPressed: detailsBloc.update,
          ),
        ],
      );

  void _goBackAndSaveIfNeeded(DetailsState state) async {
    if (state.wasModified) {
      final haveConfirmation = await _showModifiedConfirmation(
        context,
        ColorPalette.color(state.counter.colorIndex),
      );
      if (haveConfirmation) {
        detailsBloc.update();
      } else {
        navBloc.pop();
      }
    } else {
      navBloc.pop();
    }
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: ColorPicker(
          selected: ColorPalette.blue,
          onColorPicked: (newColor) {
            detailsBloc.applyColor(newColor);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Future<bool> _showModifiedConfirmation(BuildContext context, Color color) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do you want to save changes?"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            textColor: color,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          RaisedButton(
            child: Text("Yes"),
            color: color,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
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
