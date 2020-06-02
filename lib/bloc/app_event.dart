import 'didierboelens/bloc_event_state.dart';

class AppEvent extends BlocEvent {
  AppEvent(this.type);

  final AppEventType type;

  factory AppEvent.loading() => AppEvent(AppEventType.loading);

  factory AppEvent.loaded() => AppEvent(AppEventType.loaded);
}

enum AppEventType { loading, loaded }
