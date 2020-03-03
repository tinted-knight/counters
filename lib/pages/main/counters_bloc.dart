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

  void increment(int index) => fire(CountersEvent.increment(_counters[index].id));

  @override
  Stream<CounterState> eventHandler(
      CountersEvent event, CounterState currentState) async* {
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
    fire(CountersEvent.start());
    final values = await repo.getAll();
    if (values != null && values.isNotEmpty) {
      fire(CountersEvent.loaded(values));
    }
  }

  Future<void> _stepUp(int index) async {
    final toUpdate = _counters.firstWhere((item) => item.id == index).stepUp();
    await repo.update(toUpdate);
  }
}
