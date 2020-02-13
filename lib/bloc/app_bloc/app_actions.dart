import 'package:counter/model/CounterModel.dart';

class AppActions {
  AppActions();

  factory AppActions.creationCanceled() = ActionCreationCanceled;

  factory AppActions.counterCreated(CounterItem item) = ActionCounterCreated;

  factory AppActions.counterDeleted() = ActionCounterDeleted;

  factory AppActions.counterUpdated() = ActionCounterUpdated;
}

class ActionCounterCreated extends AppActions {
  ActionCounterCreated(this.counter);

  final CounterItem counter;
}

class ActionCounterDeleted extends AppActions {}

class ActionCreationCanceled extends AppActions {}

class ActionCounterUpdated extends AppActions {}