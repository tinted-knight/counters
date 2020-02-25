import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:flutter/material.dart';

import '../../bloc/helper_functions.dart';
import 'counters_event.dart';
import 'counters_state.dart';

mixin TextControllersMixin on BlocEventStateBase<CountersEvent, CounterState> {
  final valueCtrl = TextEditingController();
  final stepCtrl = TextEditingController();
  final goalCtrl = TextEditingController();
  final unitCtrl = TextEditingController();
  final titleCtrl = TextEditingController();

  void populateControllers(CounterItem counter) {
    valueCtrl.text = counter.value.toString();
    stepCtrl.text = counter.step.toString();
    goalCtrl.text = counter.goal.toString();
    unitCtrl.text = counter.unit;
    titleCtrl.text = counter.title;
  }

  void _flushControllers() {
    valueCtrl.clear();
    stepCtrl.clear();
    goalCtrl.clear();
    unitCtrl.clear();
    titleCtrl.clear();
  }

  @override
  void dispose() {
    valueCtrl.dispose();
    stepCtrl.dispose();
    goalCtrl.dispose();
    unitCtrl.dispose();
    titleCtrl.dispose();

    super.dispose();
  }
}

class CountersBloc extends BlocEventStateBase<CountersEvent, CounterState>
    with TextControllersMixin {
  CountersBloc({@required this.repo}) : super(initialState: CounterState.loading()) {
    _loadCounters();
  }

  final ILocalStorage repo;
  List<CounterItem> _counters;

  void update(int index) async {
    var updatedItem = _counters.firstWhere((item) => item.id == index).copyWith(
          title: titleCtrl.text,
          goal: goalCtrl.text.toInt(),
          value: valueCtrl.text.toInt(),
          unit: unitCtrl.text,
        );
    if (await repo.update(updatedItem)) {
      final updatedCounters =
          _counters.map((item) => item.id == index ? updatedItem : item).toList();
      fire(CountersEvent.updated(updatedCounters));
    }
  }

  @override
  Stream<CounterState> eventHandler(
      CountersEvent event, CounterState currentState) async* {
    if (event.type == CountersEventType.start) {
      yield CounterState.loading();
    }
    if (event.type == CountersEventType.loaded) {
      _counters = event.counters;
      yield CounterState.loaded(_counters);
    }
    if (event.type == CountersEventType.updated) {
      _counters = event.counters;
      yield CounterState.updated(_counters);
      _flushControllers();
      yield CounterState.loaded(_counters);
    }
  }

  void _loadCounters() async {
    fire(CountersEvent.start());
    final values = await repo.getAll();
    if (values != null && values.isNotEmpty) {
      fire(CountersEvent.loaded(values));
    }
  }
}
