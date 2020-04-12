import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/stat/stat_event.dart';
import 'package:counter/pages/stat/stat_state.dart';

class StatBloc extends BlocEventStateBase<StatEvent, StatState> {
  StatBloc(this.repo) : super(initialState: StatState.loading());

  final ILocalStorage repo;

  @override
  Stream<StatState> eventHandler(
      StatEvent event, StatState currentState) async* {
    switch (event.type) {
      case StatEventType.loading:
        yield StatState.loading();
        break;
      case StatEventType.loaded:
        yield StatState.loaded(event.stat);
        break;
      case StatEventType.empty:
        yield StatState.empty();
        break;
    }
  }

  void load(CounterItem counter) async {
    final stat = await repo.getHistoryFor(counter: counter);
    fire(StatEvent.loaded(stat));
  }
}
