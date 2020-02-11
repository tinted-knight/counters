import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';

import '../bloc/helper_functions.dart';

class CounterListBloc extends BaseBlocWithStates<CounterListStates> {
  CounterListBloc(this.storage) {
    _loadCounters();
  }

  final ILocalStorage storage;

  List<CounterItem> _counters;

  void reloadCounters() => _loadCounters();

  void resetCounters() async {
    pushState(CounterListStates._loading());
    final reseted = await _resetCounters(_counters);
    _counters = reseted;
    pushState(CounterListStates._values(_counters));
  }

  void _loadCounters() async {
    pushState(CounterListStates._loading());
//    // debug: fake delay
//    await Future.delayed(Duration(seconds: 1));
    final values = await storage.getAll();
    if (values != null && values.isNotEmpty) {
      if (await _needResetCounters()) {
        _counters = await _resetCounters(values);
        pushState(CounterListStates._values(_counters));
      } else {
        _counters = values;
        pushState(CounterListStates._values(_counters));
      }
    } else {
      _counters.clear();
      pushState(CounterListStates._empty());
    }
  }

  Future<void> _saveUpdated(List<CounterItem> counters) async {
    counters.forEach((counter) async => await storage.update(counter));
  }

  Future<bool> _needResetCounters() async {
    //todo Corner case: New Year Day
    final dbTime = await storage.getTime();
    final today = DateTime.now();
    final helper = DateTime(today.year, 1, 1, 0, 0);

    final dbDayOfYear = dbTime.difference(helper).inDays;
    final todayDayOfYear = today.difference(helper).inDays;

    return (todayDayOfYear - dbDayOfYear) >= 1;
  }

  Future<List<CounterItem>> _resetCounters(List<CounterItem> counters) async {
    await _updateTime();
    await _saveToHistory(counters);
    final resetedCounters = counters.map((counter) => counter.flush).toList();
    await _saveUpdated(resetedCounters);
    return resetedCounters;
  }

  Future<void> _saveToHistory(List<CounterItem> counters) async {
    final now = DateTime.now().millisecondsSinceEpoch.toString();
    counters.forEach((counter) async => await storage.updateHistory(counter, now));
  }

  Future<bool> _updateTime() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    return await storage.updateTime(now);
  }

  void incrementCounter(CounterItem counter) async {
    final updated = await storage.update(counter.stepUp());
    if (updated) {
      _loadCounters();
    }
  }
}

class CounterListStates {
  CounterListStates();

  factory CounterListStates._loading() = StateLoading;

  factory CounterListStates._empty() = StateEmpty;

  factory CounterListStates._values(List<CounterItem> values) = StateValues;

  factory CounterListStates._didUpdated(List<CounterItem> values) = StateDidUpdated;
}

class StateLoading extends CounterListStates {}

class StateEmpty extends CounterListStates {}

class StateDidUpdated extends CounterListStates {
  StateDidUpdated(this.values);

  final List<CounterItem> values;
}

class StateValues extends CounterListStates {
  StateValues(this.values);

  final List<CounterItem> values;
}

extension FlushCounter on CounterItem {
  CounterItem get flush => this.copyWith(value: 0);
}
