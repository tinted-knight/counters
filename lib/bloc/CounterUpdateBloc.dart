import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';

import 'helper_functions.dart';

class CounterUpdateBloc extends BaseBlocWithStates<CounterUpdateStates> {
  CounterUpdateBloc(this.storage) : super(initialState: CounterUpdateStates.idle);

  final ILocalStorage storage;

  void btnDeleteClick(CounterItem counter) async {
    if (await storage.delete(counter)) {
      pushState(CounterUpdateStates.deleted);
    } else {
      pushState(CounterUpdateStates.error);
    }
  }

  void btnCancelClick() {
    pushState(CounterUpdateStates.updated);
  }

  void btnSaveClick(
    CounterItem counter, {
    String title,
    String value,
    String step,
    String goal,
    String unit,
  }) =>
      _update(counter.copyWith(
        title: title,
        value: value.toInt(),
        step: step.toInt(),
        goal: goal.toInt(),
        unit: unit,
      ));

  bool validateInput() {
    //todo
  }

  void _update(CounterItem counter) async {
    print('updateBloc::_update');
    if (await storage.update(counter)) {
      print('updateBloc::storage.update');
      pushState(CounterUpdateStates.updated);
    } else {
      pushState(CounterUpdateStates.error);
    }
  }
}

enum CounterUpdateStates { idle, inprogress, updated, error, deleted }
