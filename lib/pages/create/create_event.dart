import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CreateEvent extends BlocEvent {
  final CreateEventType type;
  final CounterItem counterWithErrors;

  CreateEvent(this.type, {this.counterWithErrors});

  factory CreateEvent.saving(CounterItem item) => CreateEvent(CreateEventType.saving);

  factory CreateEvent.saved() => CreateEvent(CreateEventType.saved);

  factory CreateEvent.validationError(CounterItem item) => CreateEvent(
        CreateEventType.validationError,
        counterWithErrors: item,
      );
}

enum CreateEventType {
  saving,
  saved,
  validationError,
}
