import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/pages/create/create_state.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/theme/dark_theme.dart';
import 'package:counter/views/common/PropertyRow.dart';
import 'package:counter/widgets/color_picker/ColorPicker.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeLight.scaffoldBgColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text("Create counter", style: TextStyle(color: Color(0xff313131))),
        iconTheme: IconThemeData(color: Color(0xff313131)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Save", style: TextStyle(color: Color(0xff212121))),
        icon: Icon(Icons.save, color: Color(0xff212121)),
        onPressed: () => createBloc.create(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => navBloc.pop(),
            ),
          ],
        ),
      ),
      body: BlocStreamBuilder<CreateState>(
        bloc: createBloc,
        stateListener: (state) {
          if (state.hasSaved) {
            countersBloc.reload();
            navBloc.home();
          }
          if (state.isSaving) {
            showSavingDialog(context);
          }
        },
        builder: (ctx, state) {
          if (state.isIdle || state.validationError || state.isSaving) {
            return renderState(state, createBloc, navBloc);
          }

          return Center(child: Text("debug error"));
        },
      ),
    );
  }

  Widget renderState(CreateState state, CreateBloc createBloc, NavigatorBloc navBloc) {
    return LayoutBuilder(
        builder: (ctx, viewport) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewport.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      PropertyRow.title(label: "Title", controller: createBloc.titleCtrl),
                      PropertyRow.step(
                        label: "Step",
                        controller: createBloc.stepCtrl,
                        hasError: state.counterWithErrors?.hasStepError ?? false,
                      ),
                      PropertyRow.goal(
                        label: "Goal",
                        controller: createBloc.goalCtrl,
                        hasError: state.counterWithErrors?.hasGoalError ?? false,
                      ),
                      PropertyRow.unit("Unit", createBloc.unitCtrl),
                      ColorPicker(
                        onColorPicked: (color) => createBloc.setColor(color),
                        selected: ColorPalette.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
