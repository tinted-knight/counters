import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CountersEvent extends BlocEvent {
  CountersEvent(this.type, {this.counters}) : assert(type != null);

  final CountersEventType type;
  final List<CounterItem> counters;

  factory CountersEvent.start() => CountersEvent(CountersEventType.start);

  factory CountersEvent.loaded(List<CounterItem> items) => CountersEvent(
        CountersEventType.loaded,
        counters: items,
      );

  factory CountersEvent.updated(List<CounterItem> items) => CountersEvent(
        CountersEventType.updated,
        counters: items,
      );
}

enum CountersEventType { start, loaded, updated }
