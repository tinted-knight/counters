import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/i18n/app_localization.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/pages/create/create_state.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/light_theme.dart';
import 'package:counter/widgets/color_picker/ColorPicker.dart';
import 'package:counter/widgets/common/PropertyRow.dart';
import 'package:counter/widgets/debug_error_message.dart';
import 'package:counter/widgets/dialogs/saving_modal_dialog.dart';
import 'package:flutter/material.dart';

import '../../model/CounterModel.dart';
import 'create_bloc.dart';

class CreatePage extends StatelessWidget {
  static const route = "/create";

  @override
  Widget build(BuildContext context) {
    final createBloc = BlocProvider.of<CreateBloc>(context);
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);
    final locale = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeLight.scaffoldBgColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(locale.createCounter, style: TextStyle(color: Color(0xff313131))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(locale.save, style: TextStyle(color: Color(0xff212121))),
        tooltip: locale.save,
        icon: Icon(
          Icons.save,
          color: ThemeLight.iconPrimary,
          semanticLabel: locale.save,
        ),
        onPressed: () => createBloc.create(),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: ThemeLight.scaffoldBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, semanticLabel: locale.back),
              onPressed: () => navBloc.pop(),
            ),
          ],
        ),
      ),
      body: BlocStreamBuilder<CreateState>(
        bloc: createBloc,
        oneShotListener: (state) {
          if (state is CreateStateSaved) {
            countersBloc.reload();
            return navBloc.home();
          }
          if (state is CreateStateSaving) {
            return showSavingDialog(context);
          }
        },
        builder: (ctx, state) {
          if (state is CreateStateIdle ||
              state is CreateStateValidationError ||
              state is CreateStateSaving) {
            return renderState(state, createBloc, navBloc, locale);
          }

          return YouShouldNotSeeThis();
        },
      ),
    );
  }

  Widget renderState(
    CreateState state,
    CreateBloc createBloc,
    NavigatorBloc navBloc,
    AppLocalization lz,
  ) {
    CounterItem counterWithErrors;
    if (state is CreateStateValidationError) {
      counterWithErrors = state.counterWithErrors;
    }
    return LayoutBuilder(
        builder: (ctx, viewport) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewport.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      PropertyRow.title(label: lz.title, controller: createBloc.titleCtrl),
                      PropertyRow.step(
                        label: lz.step,
                        controller: createBloc.stepCtrl,
                        hasError: counterWithErrors?.hasStepError ?? false,
                      ),
                      PropertyRow.goal(
                        label: lz.goal,
                        controller: createBloc.goalCtrl,
                        hasError: counterWithErrors?.hasGoalError ?? false,
                      ),
//                      PropertyRow.unit(
//                        label: lz.unit,
//                        controller: createBloc.unitCtrl,
//                      ),
                      ColorPicker(
                        onColorPicked: (color) => createBloc.setColor(color),
                        selected: ColorPalette.defaultColor,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
