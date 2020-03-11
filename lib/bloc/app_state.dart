import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:flutter/cupertino.dart';

class AppState extends BlocState {
  AppState({
    @required this.isLoading,
    this.hasLoaded = false,
    this.isSwipeable = false,
  });

  final bool isLoading;
  final bool hasLoaded;
  final bool isSwipeable;

  factory AppState.loading() => AppState(isLoading: true);

  factory AppState.loaded(bool value) => AppState(
        isLoading: false,
        hasLoaded: true,
        isSwipeable: value,
      );
}
