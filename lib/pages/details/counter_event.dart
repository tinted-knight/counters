import 'package:counter/bloc/didierboelens/bloc_event_state.dart';

class SingleCounterEvent extends BlocEvent {
  SingleCounterEvent(this.type) : assert(type != null);

  final SingleCounterEventType type;

  factory SingleCounterEvent.loaded() => SingleCounterEvent(SingleCounterEventType.loaded);

  factory SingleCounterEvent.saving() => SingleCounterEvent(SingleCounterEventType.saving);

  factory SingleCounterEvent.loading() => SingleCounterEvent(SingleCounterEventType.loading);

  factory SingleCounterEvent.saved() => SingleCounterEvent(SingleCounterEventType.saved);

  factory SingleCounterEvent.failed() => SingleCounterEvent(SingleCounterEventType.failed);

  factory SingleCounterEvent.validationError() =>
      SingleCounterEvent(SingleCounterEventType.validationError);
}

enum SingleCounterEventType { loaded, saving, saved, failed, loading, validationError }
