import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class DetailsEvent extends BlocEvent {
  final DetailsEventType type;
  final CounterItem counter;
  final CounterItem counterWithErrors;
  final bool wasModified;

  DetailsEvent(this.type, {this.counter, this.counterWithErrors, this.wasModified});

  factory DetailsEvent.loaded(CounterItem item) => DetailsEvent(
        DetailsEventType.loaded,
        counter: item,
      );

  factory DetailsEvent.loading() => DetailsEvent(DetailsEventType.loading);

  factory DetailsEvent.saving() => DetailsEvent(DetailsEventType.saving);

  factory DetailsEvent.deleting() => DetailsEvent(DetailsEventType.deleting);

  factory DetailsEvent.doneEditing() => DetailsEvent(DetailsEventType.doneEditing);

  factory DetailsEvent.canceled({bool modified = false}) => DetailsEvent(
        DetailsEventType.canceled,
        wasModified: modified,
      );

  factory DetailsEvent.colorUpdated(CounterItem item) => DetailsEvent(
        DetailsEventType.colorUpdated,
        counter: item,
      );

  factory DetailsEvent.validationError(CounterItem item) => DetailsEvent(
        DetailsEventType.validationError,
        counterWithErrors: item,
      );
}

enum DetailsEventType {
  loading,
  loaded,
  saving,
  doneEditing,
  validationError,
  canceled,
  deleting,
  colorUpdated,
}
