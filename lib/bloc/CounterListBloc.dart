import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import '../bloc/helper_functions.dart';

class CounterListBloc extends BaseBlocWithStates<CounterListStates> {
  CounterListBloc(this.storage) {
    _loadCounters();
  }

  void _loadCounters() async {
    pushState(CounterListStates._loading());
    final values = await storage.getAll();
    if (values != null && values.isNotEmpty) {
      pushState(CounterListStates._values(values));
    } else {
      pushState(CounterListStates._empty());
    }
  }

  void incrementCounter(CounterItem counter) async {
    final updated = await storage.update(counter.stepUp());
    if (updated) {
      _loadCounters();
//      pushState(CounterListStates._didUpdated(counter));
    }
  }

  final ILocalStorage storage;
}

class CounterListStates {
  CounterListStates();

  factory CounterListStates._loading() = StateLoading;

  factory CounterListStates._empty() = StateEmpty;

  factory CounterListStates._values(List<CounterItem> values) = StateValues;

  factory CounterListStates._didUpdated(CounterItem counter) = StateDidUpdated;
}

class StateLoading extends CounterListStates {}

class StateEmpty extends CounterListStates {}

class StateDidUpdated extends CounterListStates {
  StateDidUpdated(this.counter);

  final CounterItem counter;
}

class StateValues extends CounterListStates {
  StateValues(this.values);

  final List<CounterItem> values;
}
