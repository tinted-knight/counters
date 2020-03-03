import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CountersEvent extends BlocEvent {
  CountersEvent(this.type, {this.counters, this.index}) : assert(type != null);

  final CountersEventType type;
  final List<CounterItem> counters;
  final int index;

  factory CountersEvent.start() => CountersEvent(CountersEventType.start);

  factory CountersEvent.loaded(List<CounterItem> items) => CountersEvent(
        CountersEventType.loaded,
        counters: items,
      );

  factory CountersEvent.increment(int id) => CountersEvent(
        CountersEventType.increment,
        index: id,
      );
}

enum CountersEventType { start, loaded, increment }
