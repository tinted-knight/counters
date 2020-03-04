import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class SingleEvent extends BlocEvent {
  final SingleEventType type;
  final CounterItem counter;
  final CounterItem counterWithErrors;

  SingleEvent(this.type, {this.counter, this.counterWithErrors});

  factory SingleEvent.loaded(CounterItem item) => SingleEvent(
        SingleEventType.loaded,
        counter: item,
      );

  factory SingleEvent.loading() => SingleEvent(SingleEventType.loading);

  factory SingleEvent.saving() => SingleEvent(SingleEventType.saving);

  factory SingleEvent.deleting() => SingleEvent(SingleEventType.deleting);

  factory SingleEvent.done() => SingleEvent(SingleEventType.done);

  factory SingleEvent.canceled() => SingleEvent(SingleEventType.canceled);

  factory SingleEvent.validationError(CounterItem item) => SingleEvent(
        SingleEventType.validationError,
        counterWithErrors: item,
      );
}

enum SingleEventType {
  loading,
  loaded,
  saving,
  done,
  validationError,
  canceled,
  deleting,
}
