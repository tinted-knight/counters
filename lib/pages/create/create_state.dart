import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CreateState extends BlocState {
  CreateState();

  factory CreateState.idle() => CreateStateIdle();

  factory CreateState.saving() => CreateStateSaving();

  factory CreateState.saved() => CreateStateSaved();

  factory CreateState.validationError(CounterItem item) => CreateStateValidationError(
        validationError: true,
        counterWithErrors: item,
      );
}

class CreateStateIdle extends CreateState {}

class CreateStateSaving extends CreateState {}

class CreateStateSaved extends CreateState {}

class CreateStateValidationError extends CreateState {
  final bool validationError;
  final CounterItem counterWithErrors;

  CreateStateValidationError({this.validationError, this.counterWithErrors});
}
