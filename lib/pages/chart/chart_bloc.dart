import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/datetime.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/chart/chart_event.dart';
import 'package:counter/pages/chart/chart_state.dart';

class ChartBloc extends BlocEventStateBase<ChartEvent, ChartState> {
  ChartBloc(this.repo) : super(initialState: ChartState.loading());

  final ILocalStorage repo;

  @override
  Stream<ChartState> eventHandler(ChartEvent event, ChartState currentState) async* {
    switch (event.type) {
      case ChartEventType.loading:
        yield ChartState.loading();
        break;
      case ChartEventType.loaded:
        yield ChartState.loaded(event.stat);
        break;
      case ChartEventType.empty:
        yield ChartState.empty();
        break;
      case ChartEventType.back:
        yield ChartState.back();
        break;
      case ChartEventType.updating:
        yield ChartState.updating(currentState.stat);
        break;
      case ChartEventType.updated:
        final updatedList = currentState.stat.map((e) {
          if (e.id == event.updatedItem.id) {
            return event.updatedItem;
          }
          return e;
        }).toList();
        yield ChartState.loaded(updatedList);
        break;
      case ChartEventType.itemExists:
        yield ChartState.itemExists(currentState.stat, event.missingValue);
        break;
      case ChartEventType.filter:
        yield ChartState.filter(currentState.stat, event.filter);
        break;
    }
  }

  void load(CounterItem counter, {bool force = false}) async {
//    if (!force && lastState != null && lastState.stat != null && lastState.stat.length > 0) {
//      fire(ChartEvent.loaded(lastState.stat));
//    }
    // returning existing data if we are not forced to reload
    if (!force && lastState != null) {
      if (lastState.isEmpty) {
        fire(ChartEvent.empty());
        return;
      }
      if (lastState.hasLoaded) {
        fire(ChartEvent.loaded(lastState.stat));
        return;
      }
    }
    final stat = await repo.getHistoryFor(counter: counter);
    if (stat == null || stat.isEmpty) {
      fire(ChartEvent.empty());
      return;
    }
    fire(ChartEvent.loaded(stat));
  }

  void showAll() => fire(ChartEvent.filter(lastState.stat, "none"));

  void updateValue(HistoryModel item, String value) async {
    if (value == null) return;
    final updatedValue = intValueOf(value);
    if (updatedValue != item.value && updatedValue >= 0) {
      fire(ChartEvent.updating());
      final updatedItem = item.copyWith(value: intValueOf(value));
      await repo.updateExistingHistoryItem(updatedItem);
      fire(ChartEvent.updated(updatedItem));
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
      fire(ChartEvent.itemExists(ExistingItem(item, value)));
    } else {
      _addValue(counter, value, dateTime);
    }
  }

  void _addValue(CounterItem counter, String value, DateTime dateTime) async {
    final result =
        await repo.insertHistory(counter.id, intValueOf(value), dateTime.millisecondsSinceEpoch);
    if (result) load(counter, force: true);
  }

  int intValueOf(String s) => int.tryParse(s) ?? -1;

  clearHistory(CounterItem item) async {
    fire(ChartEvent.updating());
    await repo.clearHistoryFor(item.id);
    await repo.insertHistory(item.id, 0, datetime());
    await repo.update(item.copyWith(value: 0));
    // !achtung fake delay
    await Future.delayed(Duration(seconds: 1));
    load(item, force: true);
  }

  void backPressed() {
    fire(ChartEvent.back());
  }
}
