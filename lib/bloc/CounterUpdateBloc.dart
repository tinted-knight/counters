import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/storage/interface.dart';

import 'helper_functions.dart';

class CounterUpdateBloc extends BaseBlocWithStates<CounterDetailsState> {
  CounterUpdateBloc(this.storage) : super(initialState: CounterDetailsState.idle());

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

class CounterDetailsState {
  CounterDetailsState();

  factory CounterDetailsState.idle() = StateIdle;

  factory CounterDetailsState.error() = StateError;

  factory CounterDetailsState.inprogress() = StateInprogress;

  factory CounterDetailsState.updated() = StateUpdated;

  factory CounterDetailsState.canceled() = StateCanceled;

  factory CounterDetailsState.deleted() = StateDeleted;

  factory CounterDetailsState.history() = StateHistory;
}

class StateIdle extends CounterDetailsState {}

class StateError extends CounterDetailsState {}

class StateInprogress extends CounterDetailsState {}

class StateUpdated extends CounterDetailsState {}

class StateCanceled extends CounterDetailsState {}

class StateDeleted extends CounterDetailsState {}

class StateHistory extends CounterDetailsState {}
