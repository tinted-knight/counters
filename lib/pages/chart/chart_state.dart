import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/datetime.dart' as dt;

class ExistingItem {
  ExistingItem(this.item, this.value);

  final HistoryModel item;
  final String value;
}

class Filter {
  const Filter();

  FilterSpecific get asSpecific => this as FilterSpecific;
}

class FilterNone extends Filter {}

class FilterWeek extends Filter {
  const FilterWeek();
}

class FilterSpecific extends Filter {
  final int datetime;

  FilterSpecific(this.datetime);

  DateTime get short => DateTime.fromMillisecondsSinceEpoch(dt.datetime(from: this.datetime));
}

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

  factory ChartState.clearing(CounterItem item, List<HistoryModel> items, Filter filter) =>
      ChartStateClearing(item, items, filter);
}

class ChartStateLoading extends ChartState {}

class ChartStateEmpty extends ChartState {}

class ChartStateLoaded extends ChartState {
  final List<HistoryModel> values;
  final Filter filter;

  ChartStateLoaded(this.values, this.filter);

  List<HistoryModel> get filtered {
    if (filter is FilterWeek) {
      return values.sublist(0, values.length > 7 ? 7 : values.length);
    }

    if (filter is FilterSpecific) {
      final index = values.indexWhere((element) {
        return filter.asSpecific.short.difference(element.datetime).inDays >= 0;
      });
      if (index != -1) {
        return values.sublist(index, values.length - index > 7 ? index + 7 : values.length);
      }
    }
    return values;
  }
}

class ChartStateUpdated extends ChartStateLoaded {
  ChartStateUpdated(List<HistoryModel> values, Filter filter) : super(values, filter);
}

class ChartStateUpdating extends ChartStateLoaded {
  ChartStateUpdating(List<HistoryModel> values, Filter filter) : super(values, filter);
}

class ChartStateClearing extends ChartStateLoaded {
  final CounterItem item;

  ChartStateClearing(this.item, List<HistoryModel> values, Filter filter) : super(values, filter);
}

class ChartStateItemExists extends ChartStateLoaded {
  final ExistingItem existingItem;

  ChartStateItemExists(List<HistoryModel> values, Filter filter, this.existingItem)
      : super(values, filter);
}
