import 'package:counter/bloc/app_event.dart';
import 'package:counter/bloc/app_state.dart';
import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BlocEventStateBase<AppEvent, AppState> {
  SharedPreferences sp;

  AppBloc() : super(initialState: AppState.loading()) {
    _loadPrefs();
  }

  void switchSwipeable() async {
    print('appBloc::switchSwipeable, ${lastState.isSwipeable}');
    final value = !lastState.isSwipeable;
    fire(AppEvent.loading());
    await sp.setBool("is_swipeable", value);
    fire(AppEvent.loaded(value));
  }

  void _loadPrefs() async {
    sp = await SharedPreferences.getInstance();
    final bool isSwipeable = sp.get("is_swipeable") ?? false;
    fire(AppEvent.loaded(isSwipeable));
  }

  @override
  Stream<AppState> eventHandler(AppEvent event, AppState currentState) async* {
    switch (event.type) {
      case AppEventType.loading:
        yield AppState.loading();
        break;
      case AppEventType.loaded:
        print('event::loaded, ${event.isSwipeable}');
        yield AppState.loaded(event.isSwipeable);
        break;
    }
  }
}
