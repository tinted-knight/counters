import 'package:counter/bloc/didierboelens/bloc_event_state.dart';

class CreateEvent extends BlocEvent {
  final CreateEventType type;

  CreateEvent(this.type);

  factory CreateEvent.idle() => CreateEvent(CreateEventType.idle);

  factory CreateEvent.saving() => CreateEvent(CreateEventType.saving);

  factory CreateEvent.saved() => CreateEvent(CreateEventType.saved);
}

enum CreateEventType {
  idle,
  saving,
  saved,
}
