import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/pages/chart/chart_state.dart';

class ChartEvent extends BlocEvent {
  ChartEvent(this.type, {this.stat, this.updatedItem, this.missingValue, this.filter});

  final ChartEventType type;
  final List<HistoryModel> stat;
  final HistoryModel updatedItem;
  final ExistingItem missingValue;
  final String filter;

  factory ChartEvent.loading() => ChartEvent(ChartEventType.loading);

  factory ChartEvent.empty() => ChartEvent(ChartEventType.empty);

  factory ChartEvent.back() => ChartEvent(ChartEventType.back);

  factory ChartEvent.updating() => ChartEvent(ChartEventType.updating);

  factory ChartEvent.updated(HistoryModel item) => ChartEvent(
        ChartEventType.updated,
        updatedItem: item,
      );

  factory ChartEvent.loaded(List<HistoryModel> items) => ChartEvent(
        ChartEventType.loaded,
        stat: items,
      );

  factory ChartEvent.filter(List<HistoryModel> items, String filter) => ChartEvent(
        ChartEventType.filter,
        stat: items,
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
  back,
  updating,
  updated,
  itemExists,
  filter,
}
