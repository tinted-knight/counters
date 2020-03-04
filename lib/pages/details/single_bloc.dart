import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/details/single_event.dart';
import 'package:counter/pages/details/single_state.dart';
import 'package:flutter/material.dart';

import '../../bloc/helper_functions.dart';

class SingleBloc extends BlocEventStateBase<SingleEvent, SingleState> with TextControllersMixin {
  SingleBloc({this.repo}) : super(initialState: SingleState.loading());

  final ILocalStorage repo;

  void load(CounterItem item) {
    fire(SingleEvent.loaded(item));
    populateControllers(item);
  }

  void update() async {
    final updatedItem = fillFromControllers(lastState.counter);
    if (!isValid(updatedItem)) {
      fire(SingleEvent.validationError(updatedItem));
      return;
    }

    fire(SingleEvent.saving());
    // todo fake
    await Future.delayed(Duration(seconds: 1));
    if (await repo.update(updatedItem)) {
      fire(SingleEvent.done());
    }
  }

  void delete(CounterItem item) async {
    fire(SingleEvent.deleting());
    // todo fake
    await Future.delayed(Duration(seconds: 1));
    if (await repo.delete(item)) {
      fire(SingleEvent.done());
    }
  }

  void cancel() => fire(SingleEvent.canceled());

  @override
  Stream<SingleState> eventHandler(SingleEvent event, SingleState currentState) async* {
    switch (event.type) {
      case SingleEventType.loading:
        yield SingleState.loading();
        break;
      case SingleEventType.loaded:
        yield SingleState.loaded(event.counter);
        break;
      case SingleEventType.saving:
        yield currentState.copyWith(isSaving: true);
        break;
      case SingleEventType.done:
        yield SingleState.done();
        break;
      case SingleEventType.validationError:
        yield currentState.copyWith(
            validationError: true, counterWithErrors: event.counterWithErrors);
        break;
      case SingleEventType.canceled:
        yield currentState.canceled();
        break;
      case SingleEventType.deleting:
        yield currentState.deleting();
        break;
    }
  }
}

extension Validation on CounterItem {
  bool get hasInvalid => value < 0 || goal < 0 || step < 0;

  bool get hasStepError => step <= 0;

  bool get hasValueError => value < 0;

  bool get hasGoalError => goal < 0;
}

mixin TextControllersMixin on BlocEventStateBase<SingleEvent, SingleState> {
  final valueCtrl = TextEditingController();
  final stepCtrl = TextEditingController();
  final goalCtrl = TextEditingController();
  final unitCtrl = TextEditingController();
  final titleCtrl = TextEditingController();

  void populateControllers(CounterItem counter) {
    valueCtrl.text = counter.value.toString();
    stepCtrl.text = counter.step.toString();
    goalCtrl.text = counter.goal.toString();
    unitCtrl.text = counter.unit;
    titleCtrl.text = counter.title;
  }

  CounterItem fillFromControllers(CounterItem item) => item.copyWith(
        title: titleCtrl.text,
        goal: intValueOf(goalCtrl.text),
        value: intValueOf(valueCtrl.text),
        step: intValueOf(stepCtrl.text),
        unit: unitCtrl.text,
      );

  bool isValid(CounterItem item) {
    if (item.hasInvalid) {
//      if (item.value < 0) valueCtrl.text += " : e";
//      if (item.step < 0) stepCtrl.text += " : e";
//      if (item.goal < 0) goalCtrl.text += " : e";
      return false;
    }
    return true;
  }

  int intValueOf(String s) {
    print('>validate: $s');
    return int.tryParse(s) ?? -1;
  }

  @override
  void dispose() {
    valueCtrl.dispose();
    stepCtrl.dispose();
    goalCtrl.dispose();
    unitCtrl.dispose();
    titleCtrl.dispose();

    super.dispose();
  }
}
