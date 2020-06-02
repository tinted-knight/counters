import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CountersEvent extends BlocEvent {
  CountersEvent(this.type, {this.counters, this.index}) : assert(type != null);

  final CountersEventType type;
  final List<CounterItem> counters;
  final int index;

  factory CountersEvent.loading() => CountersEvent(CountersEventType.loading);

  factory CountersEvent.empty() => CountersEvent(CountersEventType.empty);

  factory CountersEvent.loaded(List<CounterItem> items) => CountersEvent(
        CountersEventType.loaded,
        counters: items,
      );

  factory CountersEvent.stepUp(int id) => CountersEvent(
        CountersEventType.stepUp,
        index: id,
      );

  factory CountersEvent.stepDown(int id) => CountersEvent(
        CountersEventType.stepDown,
        index: id,
      );
}

enum CountersEventType { loading, loaded, empty, stepUp, stepDown }
