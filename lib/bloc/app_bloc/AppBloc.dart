import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';

import 'app_actions.dart';
import 'app_states.dart';

class AppBloc extends BaseBlocWithActions<AppStates, AppActions> {
  AppBloc(): super(initialState: AppStates.idle());

  @override
  void handleAction(AppActions action) {
    if (action is ActionCreationCanceled) {
      pushState(AppStates.showActionMessage("creation canceled"));
      return;
    }
    if (action is ActionCounterCreated) {
      pushState(AppStates.counterCreated());
      return;
    }
    if (action is ActionCounterDeleted) {
      pushState(AppStates.counterDeleted());
      return;
    }
    if (action is ActionCounterUpdated) {
      pushState(AppStates.counterUpdated());
      return;
    }
  }
}
