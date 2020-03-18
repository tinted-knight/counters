import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/create/create_event.dart';
import 'package:counter/pages/create/create_state.dart';
import 'package:flutter/material.dart';

class CreateBloc extends BlocEventStateBase<CreateEvent, CreateState> with TextControllersMixin {
  CreateBloc(this.repo) : super(initialState: CreateState.idle());

  final ILocalStorage repo;

  void create() async {
    final newCounter = composeFromControllers();
    fire(CreateEvent.saving(newCounter));
    if (!isValid(newCounter)) {
      fire(CreateEvent.validationError(newCounter));
      return null;
    }
    await repo.add(newCounter);
    // todo fake
    await Future.delayed(Duration(seconds: 1));
    fire(CreateEvent.saved());
  }

  @override
  Stream<CreateState> eventHandler(CreateEvent event, CreateState currentState) async* {
    switch (event.type) {
      case CreateEventType.idle:
        yield CreateState.idle();
        break;
      case CreateEventType.saving:
        yield CreateState.saving();
        break;
      case CreateEventType.saved:
        yield CreateState.saved();
        break;
      case CreateEventType.validationError:
        yield CreateState.validationError(event.counterWithErrors);
        break;
    }
  }
}

mixin TextControllersMixin on BlocEventStateBase<CreateEvent, CreateState> {
  // todo debug to easy create a counter
  final stepCtrl = TextEditingController()..text = "42";
  final goalCtrl = TextEditingController()..text = "101";
  final unitCtrl = TextEditingController()..text = "timess";
  final titleCtrl = TextEditingController()..text = "Title1";

  int color = ColorPalette.green;

  void setColor(int newColor) {
    color = newColor;
  }

  CounterItem composeFromControllers() => CounterItem(
        title: titleCtrl.text,
        step: intValueOf(stepCtrl.text),
        goal: intValueOf(goalCtrl.text),
        unit: unitCtrl.text,
        colorIndex: color,
      );

  int intValueOf(String s) {
    print('>validate: $s');
    return int.tryParse(s) ?? -1;
  }

  bool isValid(CounterItem item) => !item.hasInvalid;

  @override
  void dispose() {
    stepCtrl.dispose();
    goalCtrl.dispose();
    unitCtrl.dispose();
    titleCtrl.dispose();

    super.dispose();
  }
}

extension Validation on CounterItem {
  bool get hasInvalid => value < 0 || goal < 0 || step < 0;

  bool get hasStepError => step <= 0;

  bool get hasValueError => value < 0;

  bool get hasGoalError => goal < 0;
}
