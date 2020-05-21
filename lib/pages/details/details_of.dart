import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/details/rows/StepRow.dart';
import 'package:counter/views/details/rows/UnitRow.dart';
import 'package:counter/views/details/rows/top_row/TopRow.dart';
import 'package:counter/widgets/action_buttons.dart';
import 'package:counter/widgets/color_picker/ColorPicker.dart';
import 'package:counter/widgets/dialogs/saving_modal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/CounterModel.dart';
import '../common/confirmation_dialog_mixin.dart';
import 'single_bloc.dart';
import 'single_state.dart';

class DetailsOf extends StatefulWidget {
  const DetailsOf({Key key}) : super(key: key);

  @override
  _DetailsOfState createState() => _DetailsOfState();
}

class _DetailsOfState extends State<DetailsOf> with ConfirmationDialogMixin {
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

        return stateLoaded(state);
      },
    );
  }

  LayoutBuilder stateLoaded(DetailsState state) {
    return LayoutBuilder(
      builder: (ctx, viewport) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewport.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _appBar(state),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 150.0,
                  child: TopRow(
                    value: state.counter.value,
                    goal: state.counter.goal,
                    controller: detailsBloc.valueCtrl,
                    hasError: state.counterWithErrors?.hasValueError ?? false,
                    upButtonTap: detailsBloc.stepUp,
                    downButtonTap: detailsBloc.stepDown,
                    resetButtonTap: detailsBloc.resetValue,
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

  AppBar _appBar(DetailsState state) => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeLight.scaffoldBgColor,
        elevation: 1.0,
        title: TextField(
          decoration: InputDecoration(icon: Icon(Icons.edit)),
          controller: detailsBloc.titleCtrl,
          style: TextStyle(fontFamily: "RobotoCondensed", fontSize: 20.0),
//            style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        actions: <Widget>[
          ColorActionButton(
            inAction: false,
            onPressed: () => _showColorPicker(state.counter.colorIndex),
            color: state.counter.colorValue,
          ),
          DeleteActionButton(
            inAction: state.isDeleting,
            onPressed: () => detailsBloc.delete(state.counter),
          ),
        ],
      );

  void _goBackAndSaveIfNeeded(DetailsState state) async {
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

  void _showColorPicker(int selected) {
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
