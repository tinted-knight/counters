import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';

class StatEvent extends BlocEvent {
  StatEvent(this.type, {this.stat, this.updatedItem});

  final StatEventType type;
  final List<HistoryModel> stat;
  final HistoryModel updatedItem;

  factory StatEvent.loading() => StatEvent(StatEventType.loading);

  factory StatEvent.empty() => StatEvent(StatEventType.empty);

  factory StatEvent.back() => StatEvent(StatEventType.back);

  factory StatEvent.updating() => StatEvent(StatEventType.updating);

  factory StatEvent.updated(HistoryModel item) => StatEvent(
        StatEventType.updated,
        updatedItem: item,
      );

  factory StatEvent.loaded(List<HistoryModel> items) => StatEvent(
        StatEventType.loaded,
        stat: items,
      );
}

enum StatEventType {
  loading,
  loaded,
  empty,
  back,
  updating,
  updated,
}
