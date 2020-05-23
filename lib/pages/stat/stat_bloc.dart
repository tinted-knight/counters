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
        yield StatState.updating(currentState.stat);
        break;
      case StatEventType.updated:
        final updatedList = currentState.stat.map((e) {
          if (e.id == event.updatedItem.id) {
            return event.updatedItem;
          }
          return e;
        }).toList();
        yield StatState.loaded(updatedList);
        break;
      case StatEventType.itemExists:
        yield StatState.itemExists(currentState.stat, event.missingValue);
        break;
    }
  }

  void load(CounterItem counter) async {
    final stat = await repo.getHistoryFor(counter: counter);
    if (stat == null || stat.isEmpty) {
      fire(StatEvent.empty());
      return;
    }
    fire(StatEvent.loaded(stat));
  }

  void updateValue(HistoryModel item, String value) async {
    if (value == null) return;
    final updatedValue = intValueOf(value);
    if (updatedValue != item.value && updatedValue >= 0) {
      fire(StatEvent.updating());
      final updatedItem = item.copyWith(value: intValueOf(value));
      await repo.updateExistingHistoryItem(updatedItem);
      fire(StatEvent.updated(updatedItem));
    }
  }

  HistoryModel checkExistence(DateTime dateTime) {
    return lastState.stat.firstWhere(
      (el) {
        final elDate = DateTime.fromMillisecondsSinceEpoch(el.date);
        return (elDate.year == dateTime.year &&
            elDate.month == dateTime.month &&
            elDate.day == dateTime.day);
      },
      orElse: () => null,
    );
  }

  void addMissingValue(CounterItem counter, String value, DateTime dateTime) async {
    final item = checkExistence(dateTime);
    if (item != null) {
      fire(StatEvent.itemExists(ExistingItem(item, value)));
    } else {
      _addValue(counter, value, dateTime);
    }
  }

  void _addValue(CounterItem counter, String value, DateTime dateTime) async {
    final result = await repo.updateHistory(
      counter.copyWith(value: intValueOf(value)),
      dateTime.millisecondsSinceEpoch,
    );
    if (result) load(counter);
  }

  int intValueOf(String s) => int.tryParse(s) ?? -1;

  void backPressed() {
    fire(StatEvent.back());
  }
}
