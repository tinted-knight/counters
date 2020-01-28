import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';

class AppBloc extends BaseBlocWithActions<AppStates, AppActions> {
  AppBloc() {
    pushState(AppStates._idle());
  }

  @override
  void handleAction(AppActions action) {
    if (action is ActionCreationCanceled) {
      pushState(AppStates._showActionMessage("creation canceled"));
    }
    if (action is ActionCounterCreated) {
      pushState(AppStates._counterCreated());
    }
  }
}

class AppStates {
  AppStates();

  factory AppStates._idle() = StateIdle;

  factory AppStates._showActionMessage(String msg) = StateActionMessage;

  factory AppStates._counterCreated() = StateCounterCreated;
}

class StateIdle extends AppStates {}

class StateActionMessage extends AppStates {
  StateActionMessage(this.msg);

  final String msg;
}

class StateCounterCreated extends AppStates {}

class AppActions {
  AppActions();

  factory AppActions.creationCanceled() = ActionCreationCanceled;

  factory AppActions.counterCreated(CounterItem item) = ActionCounterCreated;
}

class ActionCounterCreated extends AppActions {
  ActionCounterCreated(this.counter);

  final CounterItem counter;
}

class ActionCreationCanceled extends AppActions {}
