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
    print('ChartBloc.eventHandler, ${event.type}');
    switch (event.type) {
      case ChartEventType.loading:
        yield ChartState.loading();
        break;
      case ChartEventType.loaded:
        yield ChartState.loaded(event.values, event.filter);
        break;
      case ChartEventType.empty:
        yield ChartState.empty();
        break;
      case ChartEventType.updating:
        yield ChartState.updating(currentState.asLoaded.values, currentState.asLoaded.filter);
        break;
      case ChartEventType.updated:
        yield ChartState.updated(event.values, event.filter);
        break;
      case ChartEventType.itemExists:
        yield ChartState.itemExists(
          currentState.asLoaded.values,
          currentState.asLoaded.filter,
          event.missingValue,
        );
        break;
    }
  }

  void load(CounterItem counter, {bool force = false}) async {
    if (lastState is ChartStateEmpty) {
      return fire(ChartEvent.empty());
    }
    if (!force && lastState != null && lastState is ChartStateLoaded) {
      return fire(ChartEvent.loaded(lastState.asLoaded.values, filter: lastState.asLoaded.filter));
    }
    final values = await repo.getHistoryFor(counter: counter);
    if (values == null || values.isEmpty) {
      fire(ChartEvent.empty());
      return;
    }
    fire(ChartEvent.loaded(values, filter: FilterWeek()));
  }

  void cycleFilter() {
    if (lastState is ChartStateEmpty) return;
    if (lastState is ChartStateLoaded && lastState.asLoaded.filter is FilterWeek) {
      return fire(ChartEvent.loaded(lastState.asLoaded.values, filter: FilterNone()));
    }
    return fire(ChartEvent.loaded(lastState.asLoaded.values, filter: FilterWeek()));
  }

  void setStartDate(DateTime datetime) {
    if (datetime == null) return;

    return fire(ChartEvent.loaded(
      lastState.asLoaded.values,
      filter: FilterSpecific(datetime.millisecondsSinceEpoch),
    ));
  }

  void fillMissingItems(CounterItem counter) async {
    fire(ChartEvent.updating());
    final data = lastState.asLoaded.values;
    var cursor = DateTime.fromMillisecondsSinceEpoch(data.last.date);
    final today = DateTime.now();
    // !achtung fake delay
    final fake = Future.delayed(Duration(milliseconds: 500));
    while ((today.difference(cursor).inDays > 1)) {
      cursor = cursor.add(Duration(days: 1));
      if (data.indexWhere((e) => areEquals(e.date, cursor.millisecondsSinceEpoch)) == -1) {
        await repo.insertHistory(counter.id, 0, cursor.millisecondsSinceEpoch);
      }
    }
    await fake;
    fire(ChartEvent.updated(lastState.asLoaded.values, lastState.asLoaded.filter));
    load(counter);
  }

  void updateValue(HistoryModel item, String value) async {
    if (value == null) return;
    final updatedValue = intValueOf(value);
    if (updatedValue != item.value && updatedValue >= 0) {
      fire(ChartEvent.updating());
      // !achtung fake delay
      final fake = Future.delayed(Duration(milliseconds: 500));
      final updatedItem = item.copyWith(value: intValueOf(value));
      await repo.updateExistingHistoryItem(updatedItem);
      final updatedList = lastState.asLoaded.values.map((e) {
        if (e.id == updatedItem.id) return updatedItem;
        return e;
      }).toList();
      await fake;
      fire(ChartEvent.updated(updatedList, lastState.asLoaded.filter));
    }
  }

  HistoryModel checkExistence(DateTime dateTime) {
    return lastState.asLoaded.values.firstWhere(
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

  Future<void> clearHistory(CounterItem item) async {
    fire(ChartEvent.updating());
    await repo.clearHistoryFor(item.id);
    await repo.insertHistory(item.id, 0, datetime());
    await repo.update(item.copyWith(value: 0));
    // !achtung fake delay
    await Future.delayed(Duration(milliseconds: 500));
    load(item, force: true);
    return fire(ChartEvent.updated(lastState.asLoaded.values, lastState.asLoaded.filter));
  }
}

extension AsLoaded on ChartState {
  ChartStateLoaded get asLoaded => this as ChartStateLoaded;

  ChartStateItemExists get asItemExists => this as ChartStateItemExists;
}
