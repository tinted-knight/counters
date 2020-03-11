import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:flutter/material.dart';

import '../../bloc/helper_functions.dart';
import 'counters_event.dart';
import 'counters_state.dart';

class CountersBloc extends BlocEventStateBase<CountersEvent, CounterState> {
  CountersBloc({@required this.repo}) : super(initialState: CounterState.loading()) {
    _loadCounters();
  }

  final ILocalStorage repo;
  List<CounterItem> _counters;

  void reload() => _loadCounters();

  void singleUpdated(CounterItem item) {
    final index = _counters.indexWhere((element) => element.id == item.id);
    _counters[index] = item;
    fire(CountersEvent.loaded(_counters));
  }

  void increment(int index) => fire(CountersEvent.increment(_counters[index].id));

  @override
  Stream<CounterState> eventHandler(CountersEvent event, CounterState currentState) async* {
    switch (event.type) {
      case CountersEventType.start:
        yield CounterState.loading();
        break;
      case CountersEventType.loaded:
        _counters = event.counters;
        yield CounterState.loaded(_counters);
        break;
      case CountersEventType.increment:
        await _stepUp(event.index);
        _loadCounters();
        break;
    }
  }

  void _loadCounters() async {
    print('countersBloc::load');
    fire(CountersEvent.start());
    // todo fake
    await Future.delayed(Duration(seconds: 1));

    final values = await repo.getAll();
    if (values != null && values.isNotEmpty) {
      if (await _needResetCounters()) {
        final reseted = await _resetCounters(values);
        fire(CountersEvent.loaded(reseted));
      } else {
        fire(CountersEvent.loaded(values));
      }
    }
  }

  Future<bool> _needResetCounters() async {
    //todo Corner case: New Year Day
    final dbTime = await repo.getTime();
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

  Future<int> _updateTime() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    return await repo.updateTime(now);
  }

  Future<void> _saveToHistory(List<CounterItem> counters, int time) async {
    counters.forEach((counter) async => await repo.updateHistory(counter, time.toString()));
  }

  Future<void> _saveUpdated(List<CounterItem> counters) async {
    counters.forEach((counter) async => await repo.update(counter));
  }

  Future<void> _stepUp(int index) async {
    final toUpdate = _counters.firstWhere((item) => item.id == index).stepUp();
    await repo.update(toUpdate);
  }
}
