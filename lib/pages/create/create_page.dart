import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/pages/create/create_state.dart';
import 'package:counter/views/create/rows/ButtonRow.dart';
import 'package:counter/views/create/rows/PropertyRow.dart';
import 'package:counter/views/create/rows/color_picker/ColorPicker.dart';
import 'package:flutter/material.dart';

import 'create_bloc.dart';

class CreatePage extends StatelessWidget {
  static const route = "/create";

  @override
  Widget build(BuildContext context) {
    print('create::build');
    final createBloc = BlocProvider.of<CreateBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create counter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: null,
          )
        ],
      ),
      body: BlocStreamBuilder<CreateState>(
        bloc: createBloc,
        stateListener: (state) {},
        builder: (ctx, state) {
          if (state.isIdle) return _content(createBloc);

          if (state.isSaving) return Center(child: Text("saving..."));

          if (state.hasSaved) return Center(child: Text("saved"));

          return Center(child: Text("error"));
        },
      ),
    );
  }

  Widget _content(CreateBloc createBloc) {
    return LayoutBuilder(
        builder: (ctx, viewport) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewport.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      PropertyRow.title("Title", createBloc.titleCtrl),
                      PropertyRow.step("Step", createBloc.stepCtrl),
                      PropertyRow.goal("Goal", createBloc.goalCtrl),
                      PropertyRow.unit("Unit", createBloc.unitCtrl),
                      ColorPicker(
                        onColorPicked: (color) => createBloc.setColor(color),
                        selected: ColorPalette.blue,
                      ),
                      Expanded(
                        child: ButtonRow(
                          onCancel: () {},
                          onCreate: () => createBloc.create(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
