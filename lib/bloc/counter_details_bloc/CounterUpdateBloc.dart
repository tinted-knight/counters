import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';

import '../helper_functions.dart';
import 'counter_details_state.dart';

class CounterDetailsBloc extends BaseBlocWithStates<CounterDetailsState> {
  CounterDetailsBloc(this.storage) : super(initialState: CounterDetailsState.idle());

  final ILocalStorage storage;

  void btnDeleteClick(CounterItem counter) async {
    if (await storage.delete(counter)) {
      pushState(CounterDetailsState.deleted());
    } else {
      pushState(CounterDetailsState.error());
    }
  }

  void btnHistoryClick(CounterItem counter) {
    pushState(CounterDetailsState.history());
  }

  void btnCancelClick() {
    pushState(CounterDetailsState.canceled());
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
      pushState(CounterDetailsState.updated());
    } else {
      pushState(CounterDetailsState.error());
    }
  }
}