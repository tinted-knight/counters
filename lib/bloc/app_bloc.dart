import 'package:counter/bloc/app_event.dart';
import 'package:counter/bloc/app_state.dart';
import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Will be used later for light / dark theme swithcing
/// and other global app-level settings
class AppBloc extends BlocEventStateBase<AppEvent, AppState> {
  SharedPreferences sp;

  AppBloc() : super(initialState: AppState.loading());

  void loadPrefs() async {
    fire(AppEvent.loaded());
  }

  @override
  Stream<AppState> eventHandler(AppEvent event, AppState currentState) async* {
    switch (event.type) {
      case AppEventType.loading:
        yield AppState.loading();
        break;
      case AppEventType.loaded:
        yield AppState.loaded();
        break;
    }
  }
}
