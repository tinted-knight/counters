import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'counters_event.dart';
import 'counters_state.dart';

class CountersBloc extends BlocEventStateBase<CountersEvent, CounterState> {
  CountersBloc({@required this.repo}) : super(initialState: CounterState.loading()) {
    _loadCounters();
  }

  final ILocalStorage repo;
  List<CounterItem> _counters;

  void saved(CounterItem counter) {}

  @override
  Stream<CounterState> eventHandler(CountersEvent event, CounterState currentState) async* {
    if (event.type == CountersEventType.start) {
      yield CounterState.loading();
    }
    if (event.type == CountersEventType.initialized) {
      yield CounterState.loaded(_counters);
    }
    if (event.type == CountersEventType.updated) {
      //
    }
  }

  void _loadCounters() async {
    fire(CountersEvent.start());
    final values = await repo.getAll();
    if (values != null && values.isNotEmpty) {
      _counters = values;
      fire(CountersEvent.initialized());
    }
  }
}
