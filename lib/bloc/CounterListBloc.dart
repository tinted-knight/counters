import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';

class CounterListBloc extends BaseBlocWithStates<CounterListStates> {
  CounterListBloc(this.storage) {
    _loadCounters();
  }

  void _loadCounters() {
    pushState(CounterListStates._loading());
    storage.getAll().then((counterList) {
      if (counterList != null) {
        print("Counterlist not null");
        pushState(CounterListStates._values(counterList));
      } else {
        print("Counterlist is null");
        pushState(CounterListStates._empty());
      }
    });
//    final values = await storage.getAll();
//    if (values != null) {
//      pushState(CounterListStates._values(values));
//    } else {
//      pushState(CounterListStates._empty());
//    }
  }

  final ILocalStorage storage;
}

class CounterListStates {
  CounterListStates();

  factory CounterListStates._loading() = StateLoading;

  factory CounterListStates._empty() = StateEmpty;

  factory CounterListStates._values(List<CounterItem> values) = StateValues;
}

class StateLoading extends CounterListStates {}

class StateEmpty extends CounterListStates {}

class StateValues extends CounterListStates {
  StateValues(this.values);

  final List<CounterItem> values;
}
