import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/details/counter_event.dart';
import 'package:counter/pages/details/counter_state.dart';
import 'package:flutter/material.dart';
import '../../bloc/helper_functions.dart';

mixin ValueValidate on BlocEventStateBase<SingleCounterEvent, SingleCounterState> {
  int validate(String s) {
    final value = int.parse(s);
    if (value < 0) throw (Exception("Value can't be SubZero"));
    return value;
  }
}

class SingleCounterBloc extends BlocEventStateBase<SingleCounterEvent, SingleCounterState>
    with ValueValidate {
  SingleCounterBloc({this.repo}) : super(initialState: SingleCounterState.loading());

  CounterItem counter;
  final ILocalStorage repo;

  final valueCtrl = TextEditingController();
  final stepCtrl = TextEditingController();
  final goalCtrl = TextEditingController();
  final unitCtrl = TextEditingController();
  final titleCtrl = TextEditingController();

  void load(CounterItem item) {
    if (counter == null || counter != item) {
      counter = item;
      _loadingImitation();
    } else {
      _hasLoaded();
    }
  }

  void save() async {
    fire(SingleCounterEvent.saving());
    try {
      final CounterItem newValue = counter.copyWith(
        title: titleCtrl.text,
        value: validate(valueCtrl.text),
        step: validate(stepCtrl.text),
        goal: validate(goalCtrl.text),
        unit: unitCtrl.text,
      );
      await repo.update(newValue);
      // todo fake
      Future.delayed(Duration(seconds: 1));
      counter = newValue;
      fire(SingleCounterEvent.saved());
    } catch (e, s) {
      print(s);
      fire(SingleCounterEvent.validationError());
    }
  }

  void _loadingImitation() async {
    fire(SingleCounterEvent.loading());
    // todo fake
    await Future.delayed(Duration(seconds: 1));
    _hasLoaded();
  }

  void _hasLoaded() {
    valueCtrl.text = counter.value.toString();
    stepCtrl.text = counter.step.toString();
    goalCtrl.text = counter.goal.toString();
    unitCtrl.text = counter.unit;
    titleCtrl.text = counter.title;

    fire(SingleCounterEvent.loaded());
  }

  @override
  Stream<SingleCounterState> eventHandler(
      SingleCounterEvent event, SingleCounterState currentState) async* {
    if (event.type == SingleCounterEventType.loaded) {
      yield SingleCounterState.loaded(counter);
    }
    if (event.type == SingleCounterEventType.validationError) {
      yield SingleCounterState.validationError();
    }
    if (event.type == SingleCounterEventType.saved) {
      yield SingleCounterState.saved();
    }
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
