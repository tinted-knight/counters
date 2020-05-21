import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/details/rows/StepRow.dart';
import 'package:counter/views/details/rows/UnitRow.dart';
import 'package:counter/views/details/rows/top_row/TopRow.dart';
import 'package:counter/widgets/action_buttons.dart';
import 'package:counter/widgets/color_picker/ColorPicker.dart';
import 'package:counter/widgets/debug_error_message.dart';
import 'package:counter/widgets/dialogs/saving_modal_dialog.dart';
import 'package:counter/widgets/dialogs/yes_no_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/CounterModel.dart';
import 'single_bloc.dart';
import 'single_state.dart';

class DetailsOf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final detailsBloc = BlocProvider.of<DetailsBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    return BlocStreamBuilder<DetailsState>(
      bloc: detailsBloc,
      oneShotListener: (state) async {
        if (state is DetailsStateValidationError) {
          _showMessage(context, msg: "validation error");
          return;
        }
        if (state is DetailsStateDone) {
          countersBloc.reload();
          navBloc.home();
          return;
        }
        if (state is DetailsStateCanceled) {
          _goBackAndSaveIfNeeded(context, state: state);
          return;
        }
        if (state is DetailsStateColorUpdated) {
          countersBloc.singleUpdated(state.counter);
          Navigator.of(context).pop();
          return;
        }
        if (state is DetailsStateSaving) {
          showSavingDialog(context, accent: state.counter.colorValue);
          return;
        }
      },
      builder: (context, state) {
        if (state is DetailsStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is DetailsStateDone) return Container();

        if (state is DetailsStateLoaded || state is DetailsStateValidationError) {
          return stateLoaded(context, state: state, detailsBloc: detailsBloc);
        }

        return YouShouldNotSeeThis();
      },
    );
  }

  LayoutBuilder stateLoaded(
    BuildContext context, {
    DetailsStateLoaded state,
    DetailsBloc detailsBloc,
  }) {
    final validationError = state is DetailsStateValidationError;
    print('_DetailsOfState.stateLoaded, $validationError');

    return LayoutBuilder(
      builder: (ctx, viewport) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewport.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _appBar(context, state: state, detailsBloc: detailsBloc),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 150.0,
                  child: TopRow(
                    value: state.counter.value,
                    goal: state.counter.goal,
                    controller: detailsBloc.valueCtrl,
                    hasError: validationError ? state.counter.hasValueError : false,
                    upButtonTap: detailsBloc.stepUp,
                    downButtonTap: detailsBloc.stepDown,
                    resetButtonTap: detailsBloc.resetValue,
                  ),
                ),
                StepRow(
                  controller: detailsBloc.stepCtrl,
                  hasError: validationError ? state.counter.hasStepError : false,
                ),
                GoalRow(
                  controller: detailsBloc.goalCtrl,
                  hasError: validationError ? state.counter.hasGoalError : false,
                ),
                UnitRow(controller: detailsBloc.unitCtrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, {DetailsStateLoaded state, DetailsBloc detailsBloc}) =>
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeLight.scaffoldBgColor,
        elevation: 1.0,
        title: TextField(
          decoration: InputDecoration(icon: Icon(Icons.edit)),
          controller: detailsBloc.titleCtrl,
          style: TextStyle(fontFamily: "RobotoCondensed", fontSize: 20.0),
        ),
        actions: <Widget>[
          ColorActionButton(
            inAction: false,
            onPressed: () => _showColorPicker(
              context,
              selected: state.counter.colorIndex,
              detailsBloc: detailsBloc,
            ),
            color: state.counter.colorValue,
          ),
          DeleteActionButton(
            inAction: state is DetailsStateDeleting,
            onPressed: () => detailsBloc.delete(state.counter),
          ),
        ],
      );

  void _goBackAndSaveIfNeeded(
    BuildContext context, {
    DetailsStateCanceled state,
    DetailsBloc detailsBloc,
    NavigatorBloc navBloc,
  }) async {
    if (state.wasModified) {
      final haveConfirmation = await yesNoDialog(context, color: state.counter.colorValue);
      if (haveConfirmation) {
        detailsBloc.update();
      } else {
        navBloc.pop();
      }
    } else {
      navBloc.pop();
    }
  }

  void _showColorPicker(BuildContext context, {int selected, DetailsBloc detailsBloc}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: ColorPicker(
          selected: selected,
          onColorPicked: (newColor) {
            detailsBloc.applyColor(newColor);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, {String msg}) {
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
