import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';

class StatEvent extends BlocEvent {
  StatEvent(this.type, {this.stat});

  final StatEventType type;
  final List<HistoryModel> stat;

  factory StatEvent.loading() => StatEvent(StatEventType.loading);

  factory StatEvent.empty() => StatEvent(StatEventType.empty);

  factory StatEvent.back() => StatEvent(StatEventType.back);

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
}
