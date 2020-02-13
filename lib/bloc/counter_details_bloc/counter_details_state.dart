class CounterDetailsState {
  CounterDetailsState();

  factory CounterDetailsState.idle() = DetailsStateIdle;

  factory CounterDetailsState.error() = DetailsStateError;

  factory CounterDetailsState.inprogress() = DetailsStateInprogress;

  factory CounterDetailsState.updated() = DetailsStateUpdated;

  factory CounterDetailsState.canceled() = DetailsStateCanceled;

  factory CounterDetailsState.deleted() = DetailsStateDeleted;

  factory CounterDetailsState.history() = DetailsStateHistory;
}

class DetailsStateIdle extends CounterDetailsState {}

class DetailsStateError extends CounterDetailsState {}

class DetailsStateInprogress extends CounterDetailsState {}

class DetailsStateUpdated extends CounterDetailsState {}

class DetailsStateCanceled extends CounterDetailsState {}

class DetailsStateDeleted extends CounterDetailsState {}

class DetailsStateHistory extends CounterDetailsState {}
