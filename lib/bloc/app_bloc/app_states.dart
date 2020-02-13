class AppStates {
  AppStates();

  factory AppStates.idle() = StateIdle;

  factory AppStates.showActionMessage(String msg) = StateActionMessage;

  factory AppStates.counterCreated() = StateCounterCreated;

  factory AppStates.counterDeleted() = StateCounterDeleted;

  factory AppStates.counterUpdated() = StateCounterUpdated;
}

class StateIdle extends AppStates {}

class StateActionMessage extends AppStates {
  StateActionMessage(this.msg);

  final String msg;
}

class StateCounterDeleted extends AppStates {}

class StateCounterCreated extends AppStates {}

class StateCounterUpdated extends AppStates {}