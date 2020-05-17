import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/stat/stat_event.dart';
import 'package:counter/pages/stat/stat_state.dart';

class StatBloc extends BlocEventStateBase<StatEvent, StatState> {
  StatBloc(this.repo) : super(initialState: StatState.loading());

  final ILocalStorage repo;

  @override
  Stream<StatState> eventHandler(StatEvent event, StatState currentState) async* {
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
      case StatEventType.back:
        yield StatState.back();
        break;
      case StatEventType.updating:
        print('StatBloc.eventHandler: updating');
        yield StatState.updating(currentState.stat);
        break;
      case StatEventType.updated:
        print('StatBloc.eventHandler: updated, ${event.updatedItem.value}');
        final updatedList = currentState.stat.map((e) {
          if (e.id == event.updatedItem.id) {
            return event.updatedItem;
          }
          return e;
        }).toList();
        yield StatState.loaded(updatedList);
        break;
    }
  }

  void load(CounterItem counter) async {
    final stat = await repo.getHistoryFor(counter: counter);
    fire(StatEvent.loaded(stat));
  }

  void updateValue(HistoryModel item, String value) async {
    if (value == null) return;
    final updatedValue = intValueOf(value);
    if (updatedValue != item.value && updatedValue >= 0) {
      fire(StatEvent.updating());
      final updatedItem = item.copyWith(value: intValueOf(value));
      await repo.updateExistingHistoryItem(updatedItem);
      //@achtung
      Future.delayed(Duration(milliseconds: 500));
      fire(StatEvent.updated(updatedItem));
    }
  }

  int intValueOf(String s) => int.tryParse(s) ?? -1;

  void backPressed() {
    fire(StatEvent.back());
  }
}
