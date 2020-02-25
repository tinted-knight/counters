import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CountersEvent extends BlocEvent {
  CountersEvent(this.type, {this.counterItem}) : assert(type != null);

  final CountersEventType type;
  final CounterItem counterItem;

  factory CountersEvent.start() => CountersEvent(CountersEventType.start);

  factory CountersEvent.initialized() => CountersEvent(CountersEventType.initialized);

  factory CountersEvent.updated(CounterItem item) => CountersEvent(
        CountersEventType.updated,
        counterItem: item,
      );
}

enum CountersEventType { start, initialized, updated }
