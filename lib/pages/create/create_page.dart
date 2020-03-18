import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/pages/create/create_state.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/widgets/color_picker/ColorPicker.dart';
import 'package:counter/widgets/create/ButtonRow.dart';
import 'package:counter/widgets/create/PropertyRow.dart';
import 'package:flutter/material.dart';

import '../../bloc/helper_functions.dart';
import 'create_bloc.dart';

class CreatePage extends StatelessWidget {
  static const route = "/create";

  @override
  Widget build(BuildContext context) {
    print('create::build');
    final createBloc = BlocProvider.of<CreateBloc>(context);
    final countersBloc = BlocProvider.of<CountersBloc>(context);
    final navBloc = BlocProvider.of<NavigatorBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Create counter", style: TextStyle(color: Color(0xff313131))),
        iconTheme: IconThemeData(color: Color(0xff313131)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          )
        ],
      ),
      body: BlocStreamBuilder<CreateState>(
        bloc: createBloc,
        stateListener: (state) {
          if (state.hasSaved) {
            countersBloc.reload();
            navBloc.home();
          }
          if (state.isSaving) {
            _showSavingDialog(context);
          }
        },
        builder: (ctx, state) {
          if (state.isIdle || state.validationError || state.isSaving) {
            return _content(state, createBloc, navBloc);
          }

          return Center(child: Text("debug error"));
        },
      ),
    );
  }

  Widget _content(CreateState state, CreateBloc createBloc, NavigatorBloc navBloc) {
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
                      Expanded(
                        child: CreateButtonRow(
                          onCancel: () => navBloc.pop(),
                          onCreate: () => createBloc.create(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  void _showSavingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text("saving..."),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
