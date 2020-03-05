import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';

import '../helper_functions.dart';
import 'counter_list_states.dart';

class CounterListBloc extends BaseBlocWithStates<CounterListStates> {
  CounterListBloc(this.storage) : super(initialState: CounterListStates.empty()) {
    _loadCounters();
  }

  final ILocalStorage storage;

  List<CounterItem> _counters;

  void reloadCounters() => _loadCounters();

  void resetCounters() async {
    print('resetCounters');
    pushState(CounterListStates.loading());
    final reseted = await _resetCounters(_counters);
    _counters = reseted;
    pushState(CounterListStates.values(_counters));
  }

  void _loadCounters() async {
    pushState(CounterListStates.loading());
//    // debug: fake delay
//    await Future.delayed(Duration(seconds: 1));
    final values = await storage.getAll();
    if (values != null && values.isNotEmpty) {
      if (await _needResetCounters()) {
        _counters = await _resetCounters(values);
        pushState(CounterListStates.values(_counters));
      } else {
        _counters = values;
        pushState(CounterListStates.values(_counters));
      }
    } else {
      _counters.clear();
      pushState(CounterListStates.empty());
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
    final timeToSave = await _updateTime();
    await _saveToHistory(counters, timeToSave);
    final resetedCounters = counters.map((counter) => counter.flush).toList();
    await _saveUpdated(resetedCounters);
    return resetedCounters;
  }

  Future<void> _saveToHistory(List<CounterItem> counters, int time) async {
    counters.forEach((counter) async => await storage.updateHistory(counter, time.toString()));
  }

  Future<int> _updateTime() async {
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

extension Printable on List<CounterItem> {
  void debugPrint() {
    this.forEach((element) => print("${element.title} : ${element.value}"));
  }
}
