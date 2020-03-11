import 'didierboelens/bloc_event_state.dart';

class AppEvent extends BlocEvent {
  AppEvent(this.type, {this.isSwipeable});

  final AppEventType type;
  final bool isSwipeable;

  factory AppEvent.loading() => AppEvent(AppEventType.loading);

  factory AppEvent.loaded(bool value) => AppEvent(
        AppEventType.loaded,
        isSwipeable: value,
      );
}

enum AppEventType { loading, loaded }
