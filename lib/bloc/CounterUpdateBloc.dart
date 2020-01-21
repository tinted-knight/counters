import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'helper_functions.dart';

class CounterUpdateBloc extends BaseBlocWithStates<CounterUpdateStates> {
  CounterUpdateBloc(this.storage) {
    pushState(CounterUpdateStates.idle);
  }

  final ILocalStorage storage;

  void update(
    CounterItem counter, {
    String value,
    String step,
    String goal,
    String unit,
  }) =>
      _update(counter.copyWith(
        value: value.toInt(),
        step: step.toInt(),
        goal: goal.toInt(),
        unit: unit,
      ));

  bool validateInput() {
    //todo
  }

  void _update(CounterItem counter) async {
    if (await storage.update(counter)) {
      pushState(CounterUpdateStates.success);
    } else {
      pushState(CounterUpdateStates.error);
    }
  }
}

enum CounterUpdateStates { idle, inprogress, success, error }
