import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/pages/chart/chart_state.dart';

class ChartEvent extends BlocEvent {
  ChartEvent(this.type, {this.values, this.missingValue, this.filter});

  final ChartEventType type;
  final List<HistoryModel> values;
  final ExistingItem missingValue;
  final Filter filter;

  factory ChartEvent.loading() => ChartEvent(ChartEventType.loading);

  factory ChartEvent.empty() => ChartEvent(ChartEventType.empty);

  factory ChartEvent.updating() => ChartEvent(ChartEventType.updating);

  factory ChartEvent.updated(List<HistoryModel> items, Filter filter) => ChartEvent(
        ChartEventType.updated,
        values: items,
        filter: filter,
      );

  factory ChartEvent.loaded(List<HistoryModel> items, {Filter filter}) =>
      ChartEvent(
        ChartEventType.loaded,
        values: items,
        filter: filter,
      );

  factory ChartEvent.itemExists(ExistingItem value) => ChartEvent(
        ChartEventType.itemExists,
        missingValue: value,
      );
}

enum ChartEventType {
  loading,
  loaded,
  empty,
  updating,
  updated,
  itemExists,
}
