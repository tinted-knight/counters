import 'package:counter/bloc/didierboelens/bloc_event_state.dart';

class AppState extends BlocState {
  AppState();

  factory AppState.loading() = AppStateLoading;

  factory AppState.loaded() = AppStateLoaded;
}

class AppStateLoading extends AppState {}

class AppStateLoaded extends AppState {}
