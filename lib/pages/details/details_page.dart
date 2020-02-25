import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/main/counters_bloc.dart';
import 'package:counter/pages/main/counters_state.dart';
import 'package:counter/views/details/rows/ButtonRow.dart';
import 'package:counter/views/details/rows/GoalRow.dart';
import 'package:counter/views/details/rows/StepRow.dart';
import 'package:counter/views/details/rows/UnitRow.dart';
import 'package:counter/views/details/rows/top_row/TopRow.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key}) : super(key: key);

  static const route = "/details";

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  CountersBloc countersBloc;
  int index;
  NavigatorBloc navBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (index == null) index = ModalRoute.of(context).settings.arguments;
    if (countersBloc == null) countersBloc = BlocProvider.of<CountersBloc>(context);
    if (navBloc == null) navBloc = BlocProvider.of<NavigatorBloc>(context);

//    singleBloc.load(counter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocStreamBuilder<CounterState>(
      stateListener: (state) {
        if (state.isUpdated) navBloc.pop();
      },
      bloc: countersBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state.isUpdated) {
          return Scaffold(body: Center(child: Text("updated")));
        }

        final counter = state.counters.firstWhere((item) => item.id == index);
        countersBloc.populateControllers(counter);
        return Scaffold(
          appBar: _appBar(counter.colorIndex),
          body: _body(counter),
        );
      },
    );
  }

  Widget _body(CounterItem counter) => LayoutBuilder(
        builder: (ctx, viewport) => SingleChildScrollView(
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
                      controller: countersBloc.valueCtrl,
                      upButtonTap: () {
                        print('upButtonTap');
                      },
                      downButtonTap: () {
                        print('downButtonTap');
                      },
                    ),
                    height: 150.0,
                  ),
                  StepRow(controller: countersBloc.stepCtrl),
                  GoalRow(controller: countersBloc.goalCtrl),
                  UnitRow(controller: countersBloc.unitCtrl),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        buttonTheme: Theme.of(context).buttonTheme.copyWith(
                              buttonColor: ColorPalette.bgColor(counter.colorIndex),
                            ),
                      ),
                      child: ButtonRow(
                        onClick: (type) {
                          switch (type) {
                            case ButtonType.stats:
                              _btnShowHistoryClick();
                              break;
                            case ButtonType.cancel:
//                      counterBloc.btnCancelClick();
                              break;
                            case ButtonType.save:
                              _btnSaveClick();
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _btnShowHistoryClick() {
//    return counterBloc.btnHistoryClick(counter);
  }

  void _btnSaveClick() => countersBloc.update(index);

//  void _btnSaveClick() => singleBloc.save();

  AppBar _appBar(int colorInt) {
    return AppBar(
      backgroundColor: ColorPalette.bgColor(colorInt),
      elevation: 0.0,
      title: TextField(
        controller: countersBloc.titleCtrl,
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
          onPressed: _btnShowHistoryClick,
        ),
        IconButton(
          icon: Icon(Icons.save, semanticLabel: "Save"),
          onPressed: _btnSaveClick,
        ),
      ],
    );
  }
}
