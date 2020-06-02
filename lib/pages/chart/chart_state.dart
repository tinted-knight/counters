import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';

class ExistingItem {
  ExistingItem(this.item, this.value);

  final HistoryModel item;
  final String value;
}

enum Filter { none, week }

class ChartState extends BlocState {
  ChartState();

  factory ChartState.loading() => ChartStateLoading();

  factory ChartState.empty() => ChartStateEmpty();

  factory ChartState.loaded(List<HistoryModel> items, Filter filter) =>
      ChartStateLoaded(items, filter);

  factory ChartState.updated(List<HistoryModel> items, Filter filter) =>
      ChartStateUpdated(items, filter);

  factory ChartState.updating(List<HistoryModel> items, Filter filter) =>
      ChartStateUpdating(items, filter);

  factory ChartState.itemExists(List<HistoryModel> items, Filter filter, ExistingItem value) =>
      ChartStateItemExists(items, filter, value);
}

class ChartStateLoading extends ChartState {}

class ChartStateEmpty extends ChartState {}

class ChartStateLoaded extends ChartState {
  final List<HistoryModel> values;
  final Filter filter;

  ChartStateLoaded(this.values, this.filter);

  List<HistoryModel> get filtered {
    if (filter == Filter.week) {
      return values.sublist(0, values.length > 7 ? 7 : values.length);
//      return stat.where((element) => _isWeekDifference(element.date)).toList();
    }
    return values;
  }
//  bool _isWeekDifference(int value) {
//    return DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(value)).inDays <= 7;
//  }
}

class ChartStateUpdated extends ChartStateLoaded {
  ChartStateUpdated(List<HistoryModel> values, Filter filter) : super(values, filter);
}

class ChartStateUpdating extends ChartStateLoaded {
  ChartStateUpdating(List<HistoryModel> values, Filter filter) : super(values, filter);
}

class ChartStateItemExists extends ChartStateLoaded {
  final ExistingItem existingItem;

  ChartStateItemExists(List<HistoryModel> values, Filter filter, this.existingItem)
      : super(values, filter);
}
