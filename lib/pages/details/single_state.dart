import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class DetailsState extends BlocState {
  DetailsState();

  factory DetailsState.loading() => DetailsStateLoading();

  factory DetailsState.saving(CounterItem item) => DetailsStateSaving(item);

  factory DetailsState.done() => DetailsStateDone();

  factory DetailsState.canceled(CounterItem item, bool modified) => DetailsStateCanceled(
        counter: item,
        wasModified: modified,
      );

  factory DetailsState.deleting(CounterItem item) => DetailsStateDeleting(item);

  factory DetailsState.colorUpdated(CounterItem item) => DetailsStateColorUpdated(item);

  factory DetailsState.loaded(CounterItem item) => DetailsStateLoaded(item);

  factory DetailsState.validationError(CounterItem item) => DetailsStateValidationError(item);
}

class DetailsStateLoading extends DetailsState {}

class DetailsStateDone extends DetailsState {}

class DetailsStateLoaded extends DetailsState {
  final CounterItem counter;

  DetailsStateLoaded(this.counter);
}

class DetailsStateSaving extends DetailsStateLoaded {
  DetailsStateSaving(CounterItem counter) : super(counter);
}

class DetailsStateDeleting extends DetailsStateLoaded {
  DetailsStateDeleting(CounterItem counter) : super(counter);
}

class DetailsStateValidationError extends DetailsStateLoaded {
  DetailsStateValidationError(CounterItem counter) : super(counter);
}

class DetailsStateColorUpdated extends DetailsStateLoaded {
  DetailsStateColorUpdated(CounterItem counter) : super(counter);
}

class DetailsStateCanceled extends DetailsStateLoaded {
  final bool wasModified;

  DetailsStateCanceled({CounterItem counter, this.wasModified}) : super(counter);
}
