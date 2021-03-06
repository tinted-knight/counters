import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/datetime.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:flutter/material.dart';

import 'counters_event.dart';
import 'counters_state.dart';

class CountersBloc extends BlocEventStateBase<CountersEvent, CounterState> {
  CountersBloc({@required this.repo}) : super(initialState: CounterState.loading()) {
    loadCounters();
  }

  final ILocalStorage repo;
  List<CounterItem> _counters;

  void reload() => loadCounters(force: true);

  void singleUpdated(CounterItem item) {
    final index = _counters.indexWhere((element) => element.id == item.id);
    _counters[index] = item;
    fire(CountersEvent.loaded(_counters));
  }

  void stepUp(int index) => fire(CountersEvent.stepUp(_counters[index].id));

  void stepDown(int index) => fire(CountersEvent.stepDown(_counters[index].id));

  @override
  Stream<CounterState> eventHandler(CountersEvent event, CounterState currentState) async* {
    switch (event.type) {
      case CountersEventType.loading:
        yield CounterState.loading();
        break;
      case CountersEventType.empty:
        yield CounterState.empty();
        break;
      case CountersEventType.loaded:
        _counters = event.counters;
        yield CounterState.loaded(_counters);
        break;
      case CountersEventType.stepUp:
        _performStepUp(event.index);
        break;
      case CountersEventType.stepDown:
        _performStepDown(event.index);
        break;
    }
  }

  void _performStepUp(int index) async {
    final updated = await _stepUp(index);
    if (updated != null) singleUpdated(updated);
  }

  void _performStepDown(int index) async {
    final updated = await _stepDown(index);
    if (updated != null) singleUpdated(updated);
  }

  void loadCounters({bool force = false}) async {
    if (!force && _counters != null && _counters.isNotEmpty) {
      return fire(CountersEvent.loaded(_counters));
    }
    fire(CountersEvent.loading());
    final List<CounterItem> values = await repo.getAll();
    if (values != null && values.isNotEmpty) {
      if (await _needResetCounters()) {
        await _resetCounters(values);
        final reseted = values.map((e) => e.copyWith(value: 0)).toList();
        return fire(CountersEvent.loaded(reseted));
      } else {
        return fire(CountersEvent.loaded(values));
      }
    } else {
      fire(CountersEvent.empty());
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

  _resetCounters(List<CounterItem> counters) async {
    await repo.updateTime();
    final timeToSave = datetime();
    _saveToHistory(counters, timeToSave);
    await repo.resetAll();
  }

  Future<void> _saveToHistory(List<CounterItem> counters, int time) async {
    counters.forEach((counter) async => await repo.insertHistory(counter.id, 0, time));
  }

  Future<CounterItem> _stepUp(int index) async {
    final toUpdate = _counters.firstWhere((item) => item.id == index).stepUp();
    if (await repo.update(toUpdate)) {
      await repo.updateTodayHistory(toUpdate.id, toUpdate.value);
      return toUpdate;
    }
    return null;
  }

  Future<CounterItem> _stepDown(int index) async {
    final toUpdate = _counters.firstWhere((item) => item.id == index).stepDown();
    if (toUpdate != null) {
      if (await repo.update(toUpdate)) return toUpdate;
    }
    return null;
  }
}
